//
//  RegisterPresenter.swift
//  PiggyBank
//

import Foundation

class RegisterPresenter {

    private var currencies: [DomainCurrencyModel] = []
    private var selectedCurrency: DomainCurrencyModel?

    private weak var view: RegisterViewController?
    private let signUpUseCase: SignUpUseCase
    private let getCurrenciesUseCase: GetCurrenciesUseCase

    init(view: RegisterViewController?, signUpUseCase: SignUpUseCase, getCurrenciesUseCase: GetCurrenciesUseCase) {
        self.view = view
        self.signUpUseCase = signUpUseCase
        self.getCurrenciesUseCase = getCurrenciesUseCase
    }

    func loadCurrencies() {
        getCurrenciesUseCase.execute { [weak self] result in
            guard let self = self else {
                return
            }
            if case let .success(currenciesDomainModels) = result {
                self.currencies = currenciesDomainModels
                if let storedCurrencyData = UserDefaults.standard.object(forKey: "selectedCurrency") as? Data,
                   let storedCurrencyData = try? JSONDecoder().decode(DomainCurrencyModel.self, from: storedCurrencyData) {
                    self.selectedCurrency = storedCurrencyData
                } else if let currency = self.currencies.first {
                    self.selectedCurrency = currency
                }

                if let selectedCurrency = self.selectedCurrency {
                    let currenyName = Locale.current.localizedString(forCurrencyCode: selectedCurrency.code)
                    DispatchQueue.main.async {
                        self.view?.loadCurrency(currency: currenyName ?? "...")
                    }
                }
            }
        }
    }

    func onRegisterPressed(nickname: String, email: String, password: String) {
        guard let selectedCurrency = self.selectedCurrency else {
            return
        }

        let domainSignUpModel = DomainSignUpModel(nickname: nickname,
                                                  password: password,
                                                  currency: selectedCurrency.code,
                                                  email: email)
        signUpUseCase.execute(domainSignUpModel: domainSignUpModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    let profileViewController = DependencyProvider.shared.get(screen: .profile)
                    self?.view?.navigationController?.pushViewController(profileViewController, animated: true)
                case let .error(error):
                    var errorString = "Unknown error occured. Please contact support team."
                    switch error {
                    case let apiError as APIError:
                        errorString = apiError.errors.joined(separator: "\n")
                    case let internalError as InternalError:
                        errorString = internalError.string ?? errorString
                    default:
                        break
                    }
                    self?.view?.onRegistrationError(error: errorString)
                }
            }
        }
    }

    func showChangeCurrencyScreen() {
        view?.navigationController?.pushViewController(DependencyProvider.shared.get(screen: .currency), animated: true)
    }
}
