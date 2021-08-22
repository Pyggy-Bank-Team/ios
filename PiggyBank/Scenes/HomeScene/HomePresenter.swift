//
//  HomePresenter.swift
//  PiggyBank
//

class HomePresenter {

    private weak var view: HomeViewController?

    init(view: HomeViewController?) {
        self.view = view
    }

    func onLoginPressed() {
        view?.navigationController?.pushViewController(DependencyProvider.shared.get(screen: .login), animated: true)
    }

    func onRegisterPressed() {
        view?.navigationController?.pushViewController(DependencyProvider.shared.get(screen: .register), animated: true)
    }
}
