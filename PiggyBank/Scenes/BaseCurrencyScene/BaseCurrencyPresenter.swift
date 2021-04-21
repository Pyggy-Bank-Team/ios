import Foundation

final class BaseCurrencyPresenter {
    
    private var currencies: [DomainCurrencyModel] = []
    
    private let getCurrenciesUseCase = GetCurrenciesUseCase(getCurrenciesRepository: GetCurrenciesDataRepository(remoteDataSource: GetCurrenciesRemoteDataSource()))
    private let signUpUseCase = SignUpUseCase(signUpRepository: SignUpDataRepository(remoteDataSource: SignUpRemoteDataSource()), saveUserCredentialsRepository: SaveUserCredentialsDataRepository())

    private let initialNickname: String
    private let initialPassword: String
    
    weak var view: BaseCurrencyViewController?
    
    init(initialNickname: String, initialPassword: String, view: BaseCurrencyViewController?) {
        self.initialNickname = initialNickname
        self.initialPassword = initialPassword
        self.view = view
    }
    
    func loadCurrencies() {
        getCurrenciesUseCase.execute { [weak self] result in
            guard let self = self else {
                return
            }
            
            if case let .success(currenciesDomainModels) = result {
                self.currencies = currenciesDomainModels
                
                let currenciesViewModels = currenciesDomainModels.map { GrandConverter.convertToViewModel(domainCurrency: $0) }
                
                DispatchQueue.main.async {
                    self.view?.loadCurrencies(currencies: currenciesViewModels)
                }
            }
        }
    }
    
    func onDone(indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        let signUpModel = DomainSignUpModel(nickname: initialNickname, password: initialPassword, currency: currency.code)
        
        signUpUseCase.execute(domainSignUpModel: signUpModel) { [weak self] result in
            guard let self = self else {
                return
            }
            
            if case .success = result {
                DispatchQueue.main.async {
                    self.view?.onDone(viewController: ProfileSceneAssembly().build())
                }
            }
        }
    }
    
}
