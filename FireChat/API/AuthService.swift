//
//  AuthService.swift
//  FireChat
//
//  Created by Kevin ahmad on 04/06/22.
//


import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
    
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email:String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void)  {
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
    }
    
    func createUser(credentials: AuthCredentials, completion:((Error?) -> Void)?) {
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return  }
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        let fullname = credentials.fullname
        
        
        storageRef.putData(imageData, metadata: nil) { meta, error in
            storageRef.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else {return}
                
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        
                        return
                    }
                    print("DEBUG: Succesfully registered user")
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let values = ["email": email,
                                  "username": username,
                                  "fullname": fullname,
                                  "uid": uid,
                                  "profileImageUrl": profileImageUrl] as [String : Any]
                    
                    Firestore.firestore().collection("users").document(uid).setData(values, completion: completion)
                    
                    
                    
                }
                
                
                
                
                
            }
        }
        
    }
    
}
