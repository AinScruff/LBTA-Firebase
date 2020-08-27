//
//  Constant.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/27/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift

struct Constants {
    
    struct API {
        static let DB_REF = Firestore.firestore()
        static let AUTH_REF = Auth.auth()
    }
    
    struct Keys {
        static let KEYCHAIN_REF = KeychainSwift()
        static let EMAIL = "email"
        static let PASSWORD = "password"
        static let KEY_PREFIX = "testKeychain"
    }
    

}
