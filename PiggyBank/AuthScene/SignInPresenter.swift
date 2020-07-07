import Foundation

final class SignInPresenter: IAuthPresenter {
    
    weak var view: IAuthView?
    
    init(view: IAuthView) {
        self.view = view
    }
    
    func onViewDidLoad(request: AuthDTOs.ViewDidLoad.Request) {
        view?.onViewDidLoad(response: .init(screenTitle: "Sign in", hintActionTitle: "Don't have an account? Sign up"))
    }
    
    func onPrimaryAction(request: AuthDTOs.PrimaryAction.Request) {
        
    }
    
}
