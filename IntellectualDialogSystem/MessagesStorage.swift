import Foundation

class MessagesStorage: Codable {
    static var messages = [Message]()
}

struct Message: Codable {
    var text: String
    var isBot: Bool
}
