//
//  User.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/17/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation

struct User: Codable {
    var uid: String?
    var name: String?
    var imageURL: URL?
    var imageName: String?
    
    init(uid: String? = nil, name: String? = nil, imageURL: URL? = nil , imageName: String? = nil) {
        self.uid = uid
        self.name = name
        self.imageURL = imageURL
        self.imageName = imageName
    }
}
