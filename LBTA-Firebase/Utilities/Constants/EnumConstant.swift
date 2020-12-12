//
//  EnumConstant.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/27/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation

enum ValidationError: LocalizedError {
    
    case emptyNameField
    case emptyEmailField
    case emptyPasswordField
    case nameFormatInvalid
    case emailFormatInvalid
    case passwordFormatInvalid
    case passwordTooShort
    
    var errorDescription: String? {
        switch self {
        case .emptyNameField:
            return "Name is required."
        case .emptyEmailField:
            return "Email is required."
        case .emptyPasswordField:
            return "Password is required."
        case .nameFormatInvalid:
            return "Name Format is Invalid"
        case .emailFormatInvalid:
            return "Email Format is Invalid"
        case .passwordFormatInvalid:
            return "Password Format is Invalid"
        case .passwordTooShort:
            return "Password must be 6 characters long"
        }
    }
}
