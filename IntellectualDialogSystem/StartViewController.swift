import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var resumeOldDialog: UIButton!
    @IBOutlet weak var startNewDialog: UIButton!
    
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

}

