//
//  SignUp+Validation.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/27/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation

class SignUpValidationService {
    
    // MARK: - Properties
    
    static let shared = SignUpValidationService()
    
    private let validation = ValidationService.shared
    
    // MARK: - Methods
    
    func isNameValid(_ name: String) throws -> String {
        
        do {
            let name = try validation.isNameEmpty(name)
            
            return name
        } catch ValidationError.emptyNameField {
            throw ValidationError.emptyNameField
        }
        
    }
    
    func isEmailValid(_ email: String) throws -> String {
        
        do {
            var email = try validation.isEmailEmpty(email)
            
            email = try validation.isEmailFormatValid(email)
            
            return email
        } catch ValidationError.emptyEmailField{
            throw ValidationError.emptyEmailField
        } catch ValidationError.emailFormatInvalid {
            throw ValidationError.emailFormatInvalid
        }
        
    }
    
    func isPasswordValid(_ password: String) throws -> String {
        
        do {
            var password = try validation.isPasswordEmpty(password)
            
            password = try validation.isPasswordFormatValid(password)
            
            return password
        } catch ValidationError.emptyPasswordField {
            throw ValidationError.emptyPasswordField
        } catch ValidationError.passwordFormatInvalid {
            throw ValidationError.passwordFormatInvalid
        } catch ValidationError.passwordTooShort {
            throw ValidationError.passwordTooShort
        }
        
    }
    
}
