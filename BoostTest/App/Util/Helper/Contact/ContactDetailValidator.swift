//
//  ContactDetailValidator.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation

typealias ContactDetailError = ContactDetailValidator.ContactDetailError

struct ContactDetailValidator {
    
    enum ContactDetailError: Error {
        case firstName(Bool)
        case lastName(Bool)
        case email
        case phoneNum
        
        var errorMessage: String {
            var errorMsg = ""
            var fieldName = ""
            switch self {
            case .firstName(let isEmpty):
                fieldName = "First Name"
                errorMsg = isEmpty ? "%@ is required" : "Wrong Format %@"
                
            case .lastName(let isEmpty):
                fieldName = "Last Name"
                errorMsg = isEmpty ? " %@ is required" : "Wrong Format %@"
                
            case .email:
                fieldName = "Email"
                errorMsg = "Wrong Format %@"
                
            case .phoneNum:
                fieldName = "Phone Number"
                errorMsg = "Wrong Format %@"
            }
            
            return String(format: errorMsg, fieldName)
        }
    }
    
    static func validateContactDetail(_ profile: Profile) throws {
        
        // First name
        if !profile.firstName.isEmpty {
            if !Validator.isValidName( profile.firstName) {
                throw ContactDetailError.firstName(false)
            }
        } else {
            throw ContactDetailError.firstName(true)
        }
        
        // Last name
        if !profile.lastName.isEmpty {
            if !Validator.isValidName( profile.lastName) {
                throw ContactDetailError.lastName(false)
            }
        } else {
            throw ContactDetailError.lastName(true)
        }
        
        // Email
        if let email = profile.email, !email.isEmpty {
            if !Validator.isValidEmail(email) {
                throw ContactDetailError.email
            }
        }
        
        // Phone Num
        if let phoneNum = profile.phone, !phoneNum.isEmpty {
            if !Validator.isValidPhoneNum(phoneNum) {
                throw ContactDetailError.phoneNum
            }
        }
    }
    
}
