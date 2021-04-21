import UIKit

final class StartPresenter {
    
    private weak var view: StartViewController?
    
    private let getUserCredentials = GetUserCredentialsUseCase(getUserCredentialsRepository: GetUserCredentialsDataRepository())

    init(view: StartViewController?) {
        self.view = view
    }
    
    func viewDidLoad() {
        getUserCredentials.execute { [weak self] result in
            if case let .success(model) = result {
                var vcs = [AuthSceneAssembly(mode: .signIn).build()]

                if model != nil {
                    vcs.append(ProfileSceneAssembly().build())
                }

                DispatchQueue.main.async {
                    self?.view?.viewDidLoad(vcs: vcs)
                }
            }
        }
        
//        view?.viewDidLoad(vcs: [AuthSceneAssembly(mode: .signIn).build()])
    }
    
}
