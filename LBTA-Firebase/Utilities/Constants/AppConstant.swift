//
//  Constant.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/27/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation
import Firebase

struct Constants {
    
    struct API {
        static let DB_REF = Firestore.firestore()
        static let AUTH_REF = Auth.auth()
    }
    
}
