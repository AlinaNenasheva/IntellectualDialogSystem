import UIKit
import ApiAI
import Kommunicate
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Kommunicate.setup(applicationId:"LhCt3V0R6ByyR9u9riAPrg4hZmPp4wL8")
        let kmUser = KMUser()
        kmUser.userId = "Alina Nen"
        // Pass userId here NOTE : +,*,? are not allowed chars in userId.
        kmUser.email = "alinochka.no1@gmail.com" // Optional

        // Use this same API for login
        Kommunicate.registerUser(kmUser, completion: {
            response, error in
            guard error == nil else {return}
            print(" login Success ")
            // You can launch the chat screen on success of login
        })
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

