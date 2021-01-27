//
//  ProfileViewController.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 14/01/2021.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = Variables.currentUser{
            fullName.text = "\(user.firstName) \(user.lastName)"
            birthday.text = user.birthday
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonPushed(_ sender: Any) {
        //LoginVC
        let viewController = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.loginViewController) as? ViewController
        do {
            let fileURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("userdata.json")

            try JSONSerialization.data(withJSONObject:[])
                .write(to: fileURL)
        } catch {
            print(error)
        }//22
        view.window?.rootViewController = viewController
        view.window?.makeKeyAndVisible()
        
        do{
            try Auth.auth().signOut()
        }
        catch{
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
