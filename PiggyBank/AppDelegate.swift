import UIKit

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DependencyProvider.shared.assembler.resolver.resolve(StartViewController.self)
        window?.makeKeyAndVisible()

        return true
    }

}
