//
//  ValidationServiceTest.swift
//  LBTA-FirebaseTests
//
//  Created by Dominique Michael Abejar on 2/1/21.
//  Copyright © 2021 NinjaTuna. All rights reserved.
//

import XCTest
@testable import LBTA_Firebase

class ValidationServiceTest: XCTestCase {

    var validation: ValidationService!
    
    override func setUp() {
        super.setUp()
        self.validation = ValidationService()
    }
    
    override func tearDown() {
        self.validation = nil
        super.tearDown()
    }
    
    func test_name_empty() throws {
        let expectedError = ValidationError.emptyNameField
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.isNameEmpty("")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_name_valid() throws {
        let testName = "Dom"
        XCTAssertNoThrow(try validation.isNameEmpty(testName))
    }
    

    func test_email_empty() throws {
        let expectedError = ValidationError.emptyEmailField
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.isEmailEmpty("")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_email_format_invalid() throws {
        let expectedError = ValidationError.emailFormatInvalid
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.isEmailFormatValid("qwejsadsa@.asda")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_email_conditions_met() throws {
        let testEmail = "qweqwe@gmail.com"
        XCTAssertNoThrow(try validation.isEmailEmpty(testEmail))
        XCTAssertNoThrow(try validation.isEmailFormatValid(testEmail))
    }
    
    func test_password_empty() throws {
        let expectedError = ValidationError.emptyPasswordField
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.isPasswordEmpty("")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_password_too_short() throws {
        let expectedError = ValidationError.passwordTooShort
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.isPasswordFormatValid("12356")) {
            thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_password_format_invalid() throws {
        let expectedError = ValidationError.passwordFormatInvalid
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.isPasswordFormatValid("12312312")) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_password_conditions_met() throws {
        let testPass = "D12345"
        XCTAssertNoThrow(try validation.isPasswordEmpty(testPass))
        XCTAssertNoThrow(try validation.isPasswordFormatValid(testPass))
    }
}
