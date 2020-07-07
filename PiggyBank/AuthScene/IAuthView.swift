import Foundation

protocol IAuthView: class {
    
    func onViewDidLoad(response: AuthDTOs.ViewDidLoad.Response)
    func onPrimaryAction(response: AuthDTOs.PrimaryAction.Response)
    
}
