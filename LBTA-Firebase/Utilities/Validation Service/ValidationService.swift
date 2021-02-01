//
//  ValidationService.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/22/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation

class ValidationService {
    
    // MARK: - Properties
    static let shared = ValidationService()
    
    // MARK: - Methods
    
    func isNameEmpty(_ name: String) throws -> String {
        guard name != "" else { throw ValidationError.emptyNameField }
        return name
    }
    
    func isEmailEmpty(_ email: String) throws -> String {
        guard email != "" else { throw ValidationError.emptyEmailField }
        return email
    }
    
    func isPasswordEmpty(_ password: String) throws -> String {
        guard password != "" else { throw ValidationError.emptyPasswordField }
        return password
    }
    
    func isEmailFormatValid(_ email: String) throws -> String {
        let emailRegex = NSPredicate(format: "SELF MATCHES %@", "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
            "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
        
        guard emailRegex.evaluate(with: email) else { throw ValidationError.emailFormatInvalid }
        
        return email
    }
    
    func isPasswordFormatValid(_ password: String) throws -> String {
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*[0-9]).{6,}$")
        
        guard password.count >= 6 else { throw ValidationError.passwordTooShort }
        guard passwordRegex.evaluate(with: password) else { throw ValidationError.passwordFormatInvalid }
        
        return password
    }
}


