import UIKit

class DialogStarterViewController: UIViewController {

    @IBOutlet weak var startNewDialog: UIButton!
    @IBOutlet weak var resumeOldDialog: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewDialog.layer.cornerRadius = 10
        resumeOldDialog.layer.cornerRadius = 10
        retriveToUserDefaults()
        resumeOldDialog.isEnabled = !MessagesStorage.messages.isEmpty
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        resumeOldDialog.isEnabled = !MessagesStorage.messages.isEmpty
    }
    
    
    @IBAction func startNewDialogButtonPressed(_ sender: Any) {
        MessagesStorage.messages.removeAll()
        UserDefaults.standard.removePersistentDomain(forName: "Messages")
        UserDefaults.standard.synchronize()
        goToMessagengerWindow()
    }
    
    
    @IBAction func resumeOldDialogButtonPressed(_ sender: Any) {
        if resumeOldDialog.isEnabled {
            retriveToUserDefaults()
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
