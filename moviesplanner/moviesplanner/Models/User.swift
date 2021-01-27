//
//  User.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 11/01/2021.
//
import UIKit
import Foundation
import FirebaseAuth
import Firebase
import FirebaseDatabase
class User: Codable {
    var email: String
    var firstName: String
    var lastName:String
    var birthday:String
    var favouriteMovies:[Movie]?
    
    
    init(email:String, firstName:String, lastName:String, birthday:String){
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.favouriteMovies = []
    }
    
    func updateFavouriteMovies(){
        let movies = self.favouriteMovies == nil ? [] : self.favouriteMovies
        let ref = Database.database().reference()
        var array = [[String:String]]()
        for movie in movies!{
            array.append([
                "id":movie.id,
                "resultType":movie.resultType,
                "image": movie.image,
                "title": movie.title,
                "resultDescription": movie.resultDescription
            ])
        }
        if let uid = Auth.auth().currentUser?.uid{
            ref.child("favouriteMovies").child(uid).setValue(array)
        }
    }
    func getFavouriteMovies(){
        
        var ref: DatabaseReference
        ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid{
            ref.child("favouriteMovies").child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
                if let movies = snapshot.value as? NSArray as? [Movie]{
                    self.favouriteMovies = movies
                }
                else{
                    self.updateFavouriteMovies()
                }
                
            })
        }
    }
    
    static func signUpUser(user:User, password:String, sender:SignUpViewController){
        Auth.auth().createUser(withEmail: user.email, password: password){ authResult, error in
                if let _ = authResult{
                    insertUserOnline(user:user)
                    insertUserLocally(password:password, sender: sender)
                    
                }
                else{
                    sender.showError()
                }
            
            }
    }
    
    static func insertUserLocally(password:String,sender:UIViewController){
        
        var ref: DatabaseReference
        ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid{
            //sender.transitionToHome()
            ref.child("users").child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
                if var dict = snapshot.value as? NSDictionary as? Dictionary<String,String>{
                    dict["password"] = password
                    Variables.currentUser = User(email: dict["email"]!, firstName: dict["firstName"]!, lastName: dict["lastName"]!, birthday: dict["birthday"]!)
                    ref.child("favouriteMovies").child(uid).observeSingleEvent(of: .value, with: { snapshot in
                        var array = [Movie]()
                           for child in snapshot.children {
                               let snap = child as! DataSnapshot
                               let favmovie = snap.value as! [String: String]
                               let movie = Movie(id: favmovie["id"]!, resultType: favmovie["resultType"]!, image: favmovie["image"]!, title: favmovie["title"]!, resultDescription: favmovie["resultDescription"]!)
                            array.append(movie)
                           }
                        Variables.currentUser?.favouriteMovies = array
                        sender.transitionToHome()
                       })
//                    if let uid = Auth.auth().currentUser?.uid{
//                        ref.child("favouriteMovies").child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
//                            if let movies = snapshot.value as? NSArray as? [Movie]{
//                                Variables.currentUser?.favouriteMovies = movies
//                            }
//                            else{
//
//                            }
//                            sender.transitionToHome()
//
//                        })
//                    }
                    
                    Variables.currentUser?.getFavouriteMovies()
                    do {
                        let fileURL = try FileManager.default
                            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                            .appendingPathComponent("userdata.json")

                        try JSONSerialization.data(withJSONObject: dict)
                            .write(to: fileURL)
                    } catch {
                        print(error)
                    }//22
                }
                //22
                
            })
        }
        
    }
    
    
    
    static func signInUser(email: String, password: String, sender:ViewController){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let _ = authResult{
                insertUserLocally(password:password, sender: sender)
                
               
                
                
            }
            else{
                sender.showError()
            }
          
        }
    }
    
    static func insertUserOnline
(user:User){
        let ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid{
            ref.child("users").child(uid).setValue([
                "email":user.email,
                "firstName":user.firstName,
                "lastName":user.lastName,
                "birthday":user.birthday
            ])
            
        }
    }
    
}

class LocalUserData: Codable {
    var email: String
    var password:String
    
    
    init(email:String, password:String){
        self.email = email
        self.password = password
    }
}
