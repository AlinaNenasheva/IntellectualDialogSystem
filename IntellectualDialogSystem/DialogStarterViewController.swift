import UIKit

class DialogStarterViewController: UIViewController {

    @IBOutlet weak var startNewDialog: UIButton!
    @IBOutlet weak var resumeOldDialog: UIButton!
    let userDefaultsHandler = UserDefaultsHandler(userDefaultsKey: "Messages")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewDialog.layer.cornerRadius = 50
        resumeOldDialog.layer.cornerRadius = 50
        retriveToUserDefaults()
        resumeOldDialog.isEnabled = !MessagesStorage.messages.isEmpty
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        resumeOldDialog.isEnabled = !MessagesStorage.messages.isEmpty
    }
    
    
    @IBAction func startNewDialogButtonPressed(_ sender: Any) {
        MessagesStorage.messages.removeAll()
        userDefaultsHandler.clearUserDefaults()
        goToMessagengerWindow()
    }
    
    
    @IBAction func resumeOldDialogButtonPressed(_ sender: Any) {
        if resumeOldDialog.isEnabled {
            userDefaultsHandler.retriveToUserDefaults()
            goToMessagengerWindow()
        }
    }
    
    
    func goToMessagengerWindow() {
        performSegue(withIdentifier: "showToDialogWindow", sender: self)
    }
    
    
    func retriveToUserDefaults() {
        if let messages = UserDefaults.standard.object(forKey: "Messages") as? Data {
            let decoder = JSONDecoder()
            if let loadedMessages = try? decoder.decode([Message].self, from: messages) {
                MessagesStorage.messages = loadedMessages
            }
        }
    }
}
