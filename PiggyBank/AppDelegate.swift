import UIKit

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // to setup global appearance for the app
        Apperance.setup()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DependencyProvider.shared.get(screen: .start)
        window?.makeKeyAndVisible()

        return true
    }

}
