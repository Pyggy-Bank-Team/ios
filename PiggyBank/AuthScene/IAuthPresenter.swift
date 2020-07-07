import Foundation

protocol IAuthPresenter {
    
    func onViewDidLoad(request: AuthDTOs.ViewDidLoad.Request)
    func onPrimaryAction(request: AuthDTOs.PrimaryAction.Request)
    
}
