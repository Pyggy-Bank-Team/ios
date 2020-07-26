import UIKit

final class AuthFlow: IFlow {
    
    private lazy var signInVC = SignInSceneAssembly().build()
    private lazy var signUpVC = SignUpSceneAssembly().build()
    
    func initialVC() -> UIViewController {
        signInVC.onButtonAction = { _ in
            let accountsVC = AccountsAssembly().build()
            self.signInVC.navigationController?.pushViewController(accountsVC, animated: true)
        }
        
        signInVC.onHintButtonAction = { _ in
            self.signInVC.navigationController?.pushViewController(self.signUpVC, animated: true)
        }
        
        signUpVC.onHintButtonAction = { _ in
            self.signUpVC.navigationController?.popViewController(animated: true)
        }
        
        return signInVC
    }

}
