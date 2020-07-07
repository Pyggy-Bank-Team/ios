import UIKit

final class NavigationFlow: IFlow {
    
    private let initialFlow: IFlow
    
    init(initialFlow: IFlow) {
        self.initialFlow = initialFlow
    }
    
    func initialVC() -> UIViewController {
        let initialFlowVC = initialFlow.initialVC()
        
        return UINavigationController(rootViewController: initialFlowVC)
    }

}
