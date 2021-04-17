//
//  TestViewController.swift
//  IntellectualDialogSystem
//
//  Created by Алина Ненашева on 16.04.21.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var buttonCheck: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textFieldCheck: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func saveToUserDefaults() {
        TestStorage.messages[textFieldCheck.text ?? ""] = true
        UserDefaults.standard.set(TestStorage.messages, forKey: "Aye")
    }
    
    @IBAction func checkPressed(_ sender: Any) {
        saveToUserDefaults()
        
    }
    
    func retriveToUserDefaults() -> [String: Bool] {
        return UserDefaults.standard.object(forKey: "Aye") as? [String: Bool] ?? [String: Bool]()
    }
    
    
    @IBAction func getPressed(_ sender: Any) {
        print(retriveToUserDefaults())
    }
}
class TestStorage {
    static var messages = [String: Bool]()
}
