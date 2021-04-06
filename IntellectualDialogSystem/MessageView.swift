import UIKit

class MessageView: UIView {
    var isBot: Bool?
    lazy var imageBackgroundView: UIImageView = {
        var imageView = UIImageView()
        if let isBot = isBot {
            if isBot {
                imageView.backgroundColor = .green
            } else {
                imageView.backgroundColor = .systemBlue
            }
            }
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var messageTextLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(isBot: Bool, messageText: String, contentView: UIView) {
        let numberOfLines: Int
        if (8 * messageText.count) % Int(contentView.frame.width - 55) != 0 {
            numberOfLines = Int(8 * messageText.count) / Int(contentView.frame.width - 55) + 1
        } else {
            numberOfLines = Int(8
                                    * messageText.count) / Int(contentView.frame.width - 55)
        }
        print(numberOfLines)
        let frame = CGRect(x: 10, y: Int(contentView.frame.width) - ((numberOfLines == 1) ? 90 : numberOfLines * 60), width: Int(contentView.frame.width) - 10, height: (numberOfLines == 1) ? 90 : numberOfLines * 60 )
        super.init(frame: frame)
        self.isBot = isBot
        self.messageTextLabel
            .numberOfLines = numberOfLines + 1
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
        messageTextLabel.rightAnchor.constraint(equalTo: imageBackgroundView.rightAnchor, constant: 0).isActive = true
        messageTextLabel.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 15).isActive = true
        messageTextLabel.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: -25).isActive = true
    }
    
    func addMessage(height: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: self.frame.size.height);
        }

    }
}

