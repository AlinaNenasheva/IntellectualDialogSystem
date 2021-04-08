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
        goToMessagengerWindow()
    }
    
    @IBAction func resumeOldDialogButtonPressed(_ sender: Any) {
        goToMessagengerWindow()
    }
    
    func goToMessagengerWindow() {
        performSegue(withIdentifier: "showToDialogWindow", sender: self)
    }
    
    func retriveData() {
        
    }
}
