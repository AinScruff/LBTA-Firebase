//
//  Messages.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 9/13/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation

struct Message {
    var message: String
    var dateSent: Date
    var statusIncoming: Bool
    var statusRead: Bool
    
    init(message: String, dateSent: Date, statusIncoming: Bool, statusRead: Bool) {
        self.message = message
        self.dateSent = dateSent
        self.statusIncoming = statusIncoming
        self.statusRead = statusRead

    }
}

