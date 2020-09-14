import UIKit

final class StartPresenter {
    
    private weak var view: StartViewController?
    
    private let getUserCredentials = GetUserCredentialsUseCase()
    
    init(view: StartViewController?) {
        self.view = view
    }
    
    func viewDidLoad() {
        getUserCredentials.execute { [weak self] result in
            if case let .success(model) = result {
                var vcs = [AuthSceneAssembly(mode: .signIn).build()]
                
                if let model = model {
                    vcs.append(ProfileSceneAssembly().build())
                }
                
                DispatchQueue.main.async {
                    self?.view?.viewDidLoad(vcs: vcs)
                }
            }
        }
    }
    
}
