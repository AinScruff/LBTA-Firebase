//
//  LogInValidationService.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/27/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation

class LogInValidationService {
    
    // MARK: - Properties
    
    static let shared = LogInValidationService()
    private let validation = ValidationService.shared
    // MARK: - Methods
    
    func isEmailValid(_ email: String) throws -> String {
        do {
            return try validation.isEmailEmpty(email)
        } catch ValidationError.emptyEmailField{
            throw ValidationError.emptyEmailField
        }
    }
    
    func isPasswordValid(_ password: String) throws -> String {
        do {
            return try validation.isPasswordEmpty(password)
        } catch ValidationError.emptyPasswordField {
            throw ValidationError.emptyPasswordField
        }
    }
    
}
