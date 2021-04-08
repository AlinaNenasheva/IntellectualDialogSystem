import UIKit
import Assistant

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let authenticator = WatsonIAMAuthenticator(apiKey: "gg-ju1YQvOkPMXa2AcA10NvGtxVEr3SmuxuFKxX-Qe7c")
        let assistant = Assistant(version: "{version}", authenticator: authenticator)
        assistant.serviceURL = "https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/2e5e7a75-fbb7-4c5a-9d05-60f3b3c8120b"

        assistant.disableSSLVerification()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

