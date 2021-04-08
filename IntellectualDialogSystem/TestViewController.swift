import UIKit

class TestViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var viewForTest: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var messageViews = [MessageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        let messageView = MessageView(isBot: false, messageText:"Hi my dear friend", contentView: viewForTest)
        messageViews.insert(messageView, at: 0)
        moveAllMessageViewsUp()
        let messageView2 = MessageView(isBot: false, messageText:"Hi dickhead", contentView: viewForTest)
        messageViews.insert(messageView2, at: 0)
        moveAllMessageViewsUp()
        let messageView3 = MessageView(isBot: false, messageText:"Hi beautiful", contentView: viewForTest)
        messageViews.insert(messageView3, at: 0)
        moveAllMessageViewsUp()
        
    }
    
    func moveAllMessageViewsUp() {
        var sumHeight = [CGFloat]()
        if messageViews.count > 1 {
            for index in 1..<messageViews.count {
                sumHeight.append(messageViews[index].frame.height)
            }
            sumHeight.scan(initial: 0, +)
            for index in 1..<messageViews.count {
                messageViews[index].addMessage(height: sumHeight[index - 1])
            }
        }
    }
    
}


