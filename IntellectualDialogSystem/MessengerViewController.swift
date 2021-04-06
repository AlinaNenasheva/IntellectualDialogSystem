import UIKit

class MessengerViewController: UIViewController, UIScrollViewDelegate {
   
    @IBOutlet weak var enterMessageTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageContentView: UIView!
    
    
     override func viewDidLoad() {
         super.viewDidLoad()
        
        self.enterMessageTextField.delegate = self
        enterMessageTextField.returnKeyType = UIReturnKeyType.send
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOnContentView(_gesture:)))
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        leftSwipeGesture.direction = .left
        scrollView.addGestureRecognizer(leftSwipeGesture)
     }
    
    func loadMessages() {
        for (index, message) in MessagesStorage.messages.enumerated() {
            let messageView = MessageView(isBot: message.value, messageText: message.key, contentView: contentView)
        }
    }
    
    @objc func handleKeyboardDidShow(_ notification: Notification) {
        if let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let bottomInset = keyboard.height
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
            scrollView.contentInset = insets
            
        }
    }
    
    @objc func processSwipe(_ gesture: UISwipeGestureRecognizer) {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        let startViewController = stroyboard.instantiateViewController(identifier: String(describing: StartingViewController.self))
        navigationController?.pushViewController(startViewController, animated: true)
        }
    
    @objc func handleTapOnContentView (_gesture: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func handleKeyboardWillHide() {
        scrollView.contentInset = .zero
    }
}

extension MessengerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterMessageTextField.resignFirstResponder()
        if !(enterMessageTextField.text?.isEmpty ?? true) {
            MessagesStorage.messages[enterMessageTextField.text ?? "" ] = false
            print(enterMessageTextField.text ?? "")
            let messageView = MessageView(isBot: false, messageText: enterMessageTextField.text ?? "", contentView: messageContentView)
            enterMessageTextField.text?.removeAll()
            
        }
        view.endEditing(true)
        return true
    }
}
