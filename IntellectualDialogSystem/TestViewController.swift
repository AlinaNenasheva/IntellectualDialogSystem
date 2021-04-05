import UIKit

class TestViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var viewForTest: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self

    }
}

