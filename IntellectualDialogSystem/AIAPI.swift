import Foundation
import Assistant

class AIAPI {
    
    private static var sharedAIAPI: AIAPI = {
        let aiapi = AIAPI()
        return aiapi
    }()
    
    let assistant: Assistant!
    let groupForStartingConversation = DispatchGroup()
    var sessionID: String?
    var context: MessageContext?
    var currentMessage: String?
    
    private init() {
        assistant = Assistant(version: "2020-09-24", authenticator: WatsonIAMAuthenticator(apiKey: "gg-ju1YQvOkPMXa2AcA10NvGtxVEr3SmuxuFKxX-Qe7c"))
        assistant.serviceURL = "https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/2e5e7a75-fbb7-4c5a-9d05-60f3b3c8120b"
        assistant.disableSSLVerification()
    }
    
    func startConversation(completion: @escaping (String) -> ()) {
         assistant.createSession(assistantID: "d8774ee6-85fe-4702-8d71-30a7a2b8ce99") {
          response, error in
          guard let session = response?.result else {
            print(error?.localizedDescription ?? "unknown error")
            return
          }
            completion(session.sessionID)
        }
    }
    
    
    func sendRequest(userMessage: String, completion: @escaping (String?) -> ()) {
        let input = MessageInput(messageType: "text", text: userMessage)
        if let sessionID = self.sessionID {
            assistant.message(assistantID: "d8774ee6-85fe-4702-8d71-30a7a2b8ce99", sessionID: sessionID, input: input, context: context) {
                response, error in
                
                guard let message = response?.result else {
                    print(error?.localizedDescription ?? "unknown error")
                    return
                }
                let data = try! JSONEncoder().encode(message.output.generic?.first)
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                    if let message = json["text"] as? String {
                        completion(message)
                    }
                }
            }
            
        }
    }

    
    class func shared() -> AIAPI {
        return sharedAIAPI
    }
    
}
