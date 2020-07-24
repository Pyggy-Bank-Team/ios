import Foundation

final class SignUpPresenter: IAuthPresenter {
    
    private let signUpUseCase = SignUpUseCase()
    
    private weak var view: IAuthView?
    
    init(view: IAuthView) {
        self.view = view
    }
    
    func onViewDidLoad(request: AuthDTOs.ViewDidLoad.Request) {
        view?.onViewDidLoad(response: .init(screenTitle: "Sign up", hintActionTitle: "Already have an account? Sign in"))
    }
    
    func onPrimaryAction(request: AuthDTOs.PrimaryAction.Request) {
        signUpUseCase.execute(request: .init(username: request.username, password: request.password)) { [weak self] response in
            DispatchQueue.main.async {
                if case .success(_) = response.result {
                    self?.view?.onPrimaryAction(response: .init(message: "Success"))
                } else {
                    self?.view?.onPrimaryAction(response: .init(message: "Error: User is possibly duplicated"))
                }
            }
        }
    }
    
}
