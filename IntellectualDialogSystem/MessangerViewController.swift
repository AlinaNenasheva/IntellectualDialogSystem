import UIKit

class MessangerViewController: UIViewController, UIScrollViewDelegate {
   
    @IBOutlet weak var enterMessageTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var messageViews = [MessageView]()
    
     override func viewDidLoad() {
         super.viewDidLoad()
        
        self.enterMessageTextField.delegate = self
        enterMessageTextField.returnKeyType = UIReturnKeyType.send
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOnContentView(_gesture:)))
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(processSwipe(_:)))
        rightSwipeGesture.direction = .right
        scrollView.addGestureRecognizer(rightSwipeGesture)
        
        AIAPI.shared().startConversation { (sessionID) in
            AIAPI.shared().sessionID = sessionID 
        }
     }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if MessagesStorage.messages.isEmpty {
            messageViews = [MessageView]()
        }
        redrawOldDialog()
    }
    
    
    func redrawOldDialog() {
        for message in MessagesStorage.messages {
            messageViews.insert(MessageView(isBot: message.isBot, messageText: message.text, contentView: contentView), at: 0)
                moveAllMessageViewsUp()
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
    
    
    @objc func handleKeyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    
    func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(MessagesStorage.messages) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "Messages")
        }

    }
    
    
    func getMessageResponse(userMessage: String) {
        AIAPI.shared().sendRequest(userMessage: userMessage) { (message) in
            AIAPI.shared().currentMessage = message ?? "Ошибка"
            DispatchQueue.main.async {
                MessagesStorage.messages.append(Message(text: AIAPI.shared().currentMessage ?? "Ошибка", isBot: true))
                self.saveToUserDefaults()
                self.messageViews.insert(MessageView(isBot: true, messageText: AIAPI.shared().currentMessage ?? "Ошибка", contentView: self.contentView), at: 0)
                self.moveAllMessageViewsUp()
                 }
        }
    }
    
}

extension MessangerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterMessageTextField.resignFirstResponder()
        if !(enterMessageTextField.text?.isEmpty ?? true) {
            MessagesStorage.messages.append(Message(text: enterMessageTextField.text ?? "", isBot: false))
            saveToUserDefaults()
            let messageView = MessageView(isBot: false, messageText: enterMessageTextField.text ?? "Ошибка", contentView: contentView)
            messageViews.insert(messageView, at: 0)
            moveAllMessageViewsUp()
            getMessageResponse(userMessage: enterMessageTextField.text ?? "")
            enterMessageTextField.text?.removeAll()
        }
        view.endEditing(true)
        return true
    }
}


