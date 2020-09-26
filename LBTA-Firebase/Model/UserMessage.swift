//
//  UserMessage.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 9/14/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation

struct UserMessage {
    var user: User
    var latestMessage: Message?
    
    init(user: User, latestMessage: Message?) {
        self.user = user
        self.latestMessage = latestMessage
    }
}

