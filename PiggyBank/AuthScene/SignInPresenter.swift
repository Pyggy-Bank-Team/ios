import Foundation

final class SignInPresenter: IAuthPresenter {
    
    private let signInUseCase = SignInUseCase()
    
    private weak var view: IAuthView?
    
    init(view: IAuthView) {
        self.view = view
    }
    
    func onViewDidLoad(request: AuthDTOs.ViewDidLoad.Request) {
        view?.onViewDidLoad(response: .init(screenTitle: "Sign in", hintActionTitle: "Don't have an account? Sign up"))
    }
    
    func onPrimaryAction(request: AuthDTOs.PrimaryAction.Request) {
        signInUseCase.execute(request: .init(username: request.username, password: request.password)) { [weak self] response in
            DispatchQueue.main.async {
                if case let .success(token) = response.result {
                    self?.view?.onPrimaryAction(response: .init(message: token))
                } else {
                    self?.view?.onPrimaryAction(response: .init(message: "Error: User is possibly duplicated"))
                }
            }
        }
    }
    
}
