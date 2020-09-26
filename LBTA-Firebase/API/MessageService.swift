//
//  MessageService.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 9/13/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Firebase

class MessageService {
    
    // MARK: - Properties
    
    static let shared = MessageService()
    
    private let db = Constants.API.DB_REF
    
    // MARK: - Methods
    
    func fetchUserChat(currUserID: String, completion: @escaping (UserMessage?) -> Void) {
        db.collection("chat").document(currUserID).collection("messages").getDocuments { (snapshot, err) in
            if let err = err {
                print(err)
            } else {
              
                for document in snapshot!.documents {
                    let friendID = document.documentID
                    let latestMessageRef = document.get("latestMessageRef") as! DocumentReference
                    
                    
                    
                    latestMessageRef.getDocument { (snap, error) in
                        
                        if let _ = error {
                            UserService.shared.fetchUserData(userID: friendID) { (user) in
                                if let user = user {
                                      completion(UserMessage(user: user, latestMessage: nil))
                                }
                            }
                        } else {
                            
                            if let dict = snap?.data() {
                                let dateSent = dict["dateSent"] as! Timestamp
                                let message = dict["messageContent"] as! String
                                let statusIncoming = dict["statusIncoming"] as! Bool
                                let statusRead = dict["statusRead"] as! Bool
                                
                                UserService.shared.fetchUserData(userID: friendID) { (user) in
                                    
                                    if let user = user {
                                        completion(UserMessage(user: user, latestMessage: Message(message: message, dateSent: dateSent.dateValue().toLocalTime(), statusIncoming: statusIncoming, statusRead: statusRead)))
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
              
            }
        }
    }
    
    private func fetchMessages(currUserID: String, friendID: String, completion: @escaping (Message?) -> Void) {
        
        db.collection("chat").document(currUserID).collection("messages").document(friendID).collection("conversation").getDocuments { (snapshot, err) in
            if let err = err {
                print(err)
            } else {
                for document in snapshot!.documents {
                    
                    let dateSent = document.get("dateSent") as! Timestamp
                    let message = document.get("messageContent") as! String
                    let statusIncoming = document.get("statusIncoming") as! Bool
                    let statusRead = document.get("statusRead") as! Bool
                    
                    completion(Message(message: message, dateSent: dateSent.dateValue().toLocalTime(), statusIncoming: statusIncoming, statusRead: statusRead))
                }

            }
        }
    }
    
}

// FETCH ONLY LATEST MESSAGE
// FETCH ALL MESSAGE ON CLICK

