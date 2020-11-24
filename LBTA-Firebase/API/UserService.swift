//
//  ServicesAPI.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/17/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Firebase

class UserService {
    
    // MARK: - Properties
    
    static let shared = UserService()
       
    let db = Constants.API.DB_REF
    
    // MARK: - Methods
    
    func fetchUserData(userID: String?, completion: @escaping (User?) -> Void) {
        
        if let id = userID {
            db.collection("users").document(id).getDocument { (querySnapshot, err) in
                
                if let dict = querySnapshot?.data() {
                    
                    let uid = dict["uid"] as! String
                    let name = dict["name"] as! String
                    let imageURL = dict["imageUrl"] as! String
                    let imageName = dict["imageName"] as! String
                  
                    completion(User(uid: uid, name: name, imageURL: URL(string: imageURL), imageName: imageName))
                } else {
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
    
    func fetchFriendData(userID: String?, completion: @escaping (User?) -> Void) {
  
        if let id = userID {
            db.collection("users").document(id).collection("friends").getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(nil)
                } else {
                    for document in querySnapshot!.documents {
                        let friendRef = document.get("friendRef") as! DocumentReference
                        
                        friendRef.addSnapshotListener { (snap, err) in
                            if let err = err {
                                print("Error fetching user documents: \(err)")
                            } else {
                                if let dict = snap?.data() {
    
                                    let uid = dict["uid"] as! String
                                    let name = dict["name"] as! String
                                    let imageURL = dict["imageUrl"] as! String
                                    let imageName = dict["imageName"] as! String
                            
                                    completion(User(uid: uid, name: name, imageURL: URL(string: imageURL), imageName: imageName))
                                    
                                } else {
                                    print("Error Reference or user does not Exist!!!!!")
                                }
                            }
                        }
                    }
                }
            }
        } else {
            print("User Not logged in!")
            completion(nil)
        }
    
    }
}

struct UserProfileCache {
    static let key = "userProfileCache"
    
    static func save(_ value: User!) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    
    static func get() -> User! {
        var userData: User!
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(User.self, from: data)
            return userData!
        } else {
            return userData
        }
    }
    
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
