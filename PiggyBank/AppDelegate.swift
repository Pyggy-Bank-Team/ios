import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationFlow = NavigationFlow(initialFlow: AuthFlow())
        window?.rootViewController = navigationFlow.initialVC()
        window?.makeKeyAndVisible()
        
        return true
    }

}

