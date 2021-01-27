//
//  ViewController.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 05/01/2021.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func changeField(_ sender: UITextField) {
        sender.layer.borderWidth = 0
    }
    
    @IBAction func clickLogin(_ sender: UIButton) {
        self.view.endEditing(true)
        if let email = self.email.text{
            if let password = self.password.text{
                let isNotElligible = email.isEmpty || password.isEmpty
                if email.isEmpty {
                    
                    self.email.layer.borderWidth = 1
                    
                   
                }
                if password.isEmpty {
                    self.password.layer.borderWidth = 1
                }
                if !isNotElligible{
                    User.signInUser(email: email, password: password, sender: self)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.password.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
        do{
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("userdata.json")
            let data = try String(contentsOf: fileURL, encoding: .utf8)
            let rawData = Data(data.utf8)
            if let jsonData = try? JSONDecoder().decode(LocalUserData.self, from: rawData){
                
                        
                        
                User.signInUser(email: jsonData.email, password: jsonData.password, sender: self)
                        
            }
        
        }catch{}
        
    }
    
    func showError(){
        self.email.layer.borderWidth = 1
        self.password.layer.borderWidth = 1
    }
    
    


}

