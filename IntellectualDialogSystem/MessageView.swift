import UIKit

class MessageView: UIView {
    var isBot: Bool?
    
    lazy var imageBackgroundView: UIImageView = {
        var imageView = UIImageView()
        if let isBot = isBot {
            if isBot {
                imageView.backgroundColor = .black
            } else {
                imageView.backgroundColor = .white
            }
        }
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var messageTextLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        if let isBot = isBot {
            if isBot {
                label.textColor = .white
            } else {
                label.textColor = .black
            }
        }
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(isBot: Bool, messageText: String, contentView: UIView) {
        let numberOfLines: Int
        if messageText.count  % 27 != 0 {
            numberOfLines = (messageText.count / 27) + 1
        } else {
            numberOfLines = messageText.count / 27
        }
        let frame = CGRect(x: 0, y: Int(contentView.frame.height - 60) - ((numberOfLines == 1) ? 90 : numberOfLines * 60), width: Int(contentView.frame.width), height: (numberOfLines == 1) ? 90 : numberOfLines * 60 )
        super.init(frame: frame)
        self.isBot = isBot
        self.messageTextLabel.numberOfLines = numberOfLines + 1
        self.messageTextLabel.text = messageText
        self.addCustomView()
        contentView.addSubview(self)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
       }
       
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addCustomView()
    }
    
    
    func addCustomView() {
        addSubview(imageBackgroundView)
        imageBackgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        imageBackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        imageBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    
        self.addSubview(messageTextLabel)
        messageTextLabel.leftAnchor.constraint(equalTo: imageBackgroundView.leftAnchor, constant: 25).isActive = true
        messageTextLabel.rightAnchor.constraint(equalTo: imageBackgroundView.rightAnchor, constant: -15).isActive = true
        messageTextLabel.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 15).isActive = true
        messageTextLabel.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: -25).isActive = true
    }
    
    
    func addMessage(height: CGFloat) {
        UIView.animate(withDuration: 0.1) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y - height, width: self.frame.size.width, height: self.frame.size.height);
        }
    }
}

