//
//  ServicesAPI.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/17/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Firebase

class ServicesAPI {
    
    // MARK: - Properties
    
    static let shared = ServicesAPI()
       
    let db = Constants.API.DB_REF
   
    // MARK: - Methods
    func fetchFriendData(userID: String?, completion: @escaping (User) -> Void) {
  
        // Check if user is logged in
        if let id = userID {
            // Get Friends
            db.collection("users").document(id).collection("friends").getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let friendRef = document.get("friendRef") as! DocumentReference
                        
                        // Get Friend User Data
                        friendRef.addSnapshotListener { (snap, err) in
                            if let err = err {
                                print("Error fetching user documents: \(err)")
                            } else {
                                if let dict = snap?.data() {
    
                                    let uid = dict["uid"] as! String
                                    let name = dict["name"] as! String
                                    let imageUrl = dict["imageUrl"] as! String
                                    let imageName = dict["imageName"] as! String
                                    
                                    //self.user.append(User(uid: uid, name: name, imageURL: imageUrl, imageName: imageName))
                                    completion(User(uid: uid, name: name, imageURL: imageUrl, imageName: imageName))
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
        }
    
    }
}
