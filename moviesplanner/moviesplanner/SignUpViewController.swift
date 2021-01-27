//
//  SignUpViewController.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 11/01/2021.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var fisrtName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
   
    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBAction func clickSignUp(_ sender: Any) {
        self.view.endEditing(true)
        var isElligible = true
        if self.fisrtName.text!.isEmpty{
            isElligible = false
            self.fisrtName.layer.borderWidth = 1
        }
        if self.lastName.text!.isEmpty{
            isElligible = false
            self.lastName.layer.borderWidth = 1
        }
        
        if self.email.text!.isEmpty{
            isElligible = false
            self.email.layer.borderWidth = 1
        }
        if self.password.text!.isEmpty{
            isElligible = false
            self.password.layer.borderWidth = 1
        }
        if self.password.text != self.confirmPassword.text{
            isElligible = false
            self.confirmPassword.layer.borderWidth = 1
        }
        
        if isElligible {
            let user = User(email: email.text!, firstName: fisrtName.text!, lastName: lastName.text!, birthday: getBirthdayDate())
            User.signUpUser(user: user, password: password.text!, sender: self)
        }
        
    }
    
    @IBAction func changeField(_ sender: UITextField) {
        sender.layer.borderWidth = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.email.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.password.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.fisrtName.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        self.lastName.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        
        self.confirmPassword.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        birthday.maximumDate = Date()

    }

    
    func showError(){
        self.email.layer.borderWidth = 1
        self.password.layer.borderWidth = 1
        self.fisrtName.layer.borderWidth = 1
        self.lastName.layer.borderWidth = 1
        self.confirmPassword.layer.borderWidth = 1
        
    }
    
    func getBirthdayDate()->String{
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return "\(formatter.string(from : birthday.date))"
    }


}
