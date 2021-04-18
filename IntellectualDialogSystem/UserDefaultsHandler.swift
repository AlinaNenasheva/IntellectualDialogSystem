import Foundation

class UserDefaultsHandler {
    
    private let userDefaultsKey: String
    
    init(userDefaultsKey: String) {
        self.userDefaultsKey = userDefaultsKey
    }
    
    func retriveToUserDefaults() {
        if let messages = UserDefaults.standard.object(forKey: userDefaultsKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedMessages = try? decoder.decode([Message].self, from: messages) {
                MessagesStorage.messages = loadedMessages
            }
        }
    }
    
    
    func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(MessagesStorage.messages) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func clearUserDefaults() {
        UserDefaults.standard.removePersistentDomain(forName: userDefaultsKey)
        UserDefaults.standard.synchronize()
    }
}
