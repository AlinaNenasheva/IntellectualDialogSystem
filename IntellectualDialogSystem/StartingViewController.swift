import UIKit

class StartingViewController: UIViewController {

    
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

    @IBAction func startDialodButtonPressed(_ sender: Any) {
        goToMessagengerWindow()
    }
  
    @IBAction func resumeDialogButtonPressed(_ sender: Any) {
        goToMessagengerWindow()
    }
    
    func goToMessagengerWindow() {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let messangerViewController = stroyboard.instantiateViewController(identifier: String(describing: MessengerViewController.self))
        navigationController?.pushViewController(messangerViewController, animated: true)
    }
    
    
}


