import UIKit

class MessengerViewController: UIViewController, UIScrollViewDelegate {
   
    @IBOutlet weak var enterMessageTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageContentView: UIView!
    var messageViews = [MessageView]()
    
     override func viewDidLoad() {
         super.viewDidLoad()
        
        self.enterMessageTextField.delegate = self
        enterMessageTextField.returnKeyType = UIReturnKeyType.send
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOnContentView(_gesture:)))
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        rightSwipeGesture.direction = .right
        scrollView.addGestureRecognizer(rightSwipeGesture)
        retriveToUserDefaults()
        replaceMessages()
     }
    
    func replaceMessages() {
        if messageViews.count > 1 {
            for index in (0..<messageViews.count).reversed() {
                var sumHeight: CGFloat = 0
                for index in (0..<messageViews.count).reversed() {
                    sumHeight += messageViews[index].frame.height
                }
                messageViews[index].addMessage(height: sumHeight)
            }
        }
    }
    
    func moveAllMessageViewsUp() {
        var sumHeight = [CGFloat]()
        if messageViews.count > 1 {
            for index in 1..<messageViews.count {
                sumHeight.append(messageViews[index].frame.height)
            }
            for index in 1..<messageViews.count {
                messageViews[index].addMessage(height: messageViews[0].frame.height)
            }
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
        if gesture.direction == .right {
            performSegue(withIdentifier: "showToStarterPage", sender: self)
        }
        }
    
    @objc func handleTapOnContentView (_gesture: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func handleKeyboardWillHide() {
        scrollView.contentInset = .zero
    }
    
    func retriveToUserDefaults() {
        MessagesStorage.messages = UserDefaults.standard.object(forKey: "SavedMessages") as? [String: Bool] ?? [String: Bool]()
    }
    
    func saveToUserDefaults() {
        UserDefaults.standard.set(MessagesStorage.messages, forKey: "SavedMessages")
    }
}

extension MessengerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterMessageTextField.resignFirstResponder()
        if !(enterMessageTextField.text?.isEmpty ?? true) {
            MessagesStorage.messages[enterMessageTextField.text ?? "" ] = false
            print(enterMessageTextField.text ?? "")
            let messageView = MessageView(isBot: false, messageText: enterMessageTextField.text ?? "", contentView: messageContentView)
            messageViews.insert(messageView, at: 0)
            saveToUserDefaults()
            moveAllMessageViewsUp()
            enterMessageTextField.text?.removeAll()
        }
        view.endEditing(true)
        return true
    }
}


extension Array {
    func scan<T>(initial: T, _ f: (T, Element) -> T) -> [T] {
        return self.reduce([initial], { (listSoFar: [T], next: Element) -> [T] in
            let lastElement = listSoFar.last!
            return listSoFar + [f(lastElement, next)]
        })
    }
}
