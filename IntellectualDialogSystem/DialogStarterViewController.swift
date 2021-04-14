import UIKit

class DialogStarterViewController: UIViewController {

    @IBOutlet weak var startNewDialog: UIButton!
    @IBOutlet weak var resumeOldDialog: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewDialog.layer.cornerRadius = 10
        resumeOldDialog.layer.cornerRadius = 10
        
        if checkIfUDEmpty() {
            resumeOldDialog.isEnabled = false
        }
    }
    
    func checkIfUDEmpty() -> Bool {
        if let messages = UserDefaults.standard.array(forKey: "messages") {
            if messages.isEmpty {
                return true
            }
        }
        return false
    }
    
    
    @IBAction func startNewDialogButtonPressed(_ sender: Any) {
        MessagesStorage.messages.removeAll()
        UserDefaults.standard.removePersistentDomain(forName: "SavedMessages")
        UserDefaults.standard.synchronize()
        goToMessagengerWindow()
    }
    
    @IBAction func resumeOldDialogButtonPressed(_ sender: Any) {
        if !resumeOldDialog.isEnabled {
            retriveToUserDefaults()
            goToMessagengerWindow()
        }
    }
    
    func goToMessagengerWindow() {
        performSegue(withIdentifier: "showToDialogWindow", sender: self)
    }
    
    func retriveToUserDefaults() {
        MessagesStorage.messages = UserDefaults.standard.object(forKey: "SavedMessages") as? [String: Bool] ?? [String: Bool]()
    }
}
