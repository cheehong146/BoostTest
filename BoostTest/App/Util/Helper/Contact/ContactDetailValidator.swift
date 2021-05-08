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
                fieldName = TEXT_FIRST_NAME
                errorMsg = isEmpty ? TEXT_FIELD_IS_REQUIRED : TEXT_FIELD_FORMAT_ERROR
                
            case .lastName(let isEmpty):
                fieldName = TEXT_LAST_NAME
                errorMsg = isEmpty ? TEXT_FIELD_IS_REQUIRED : TEXT_FIELD_FORMAT_ERROR
                
            case .email:
                fieldName = TEXT_EMAIL
                errorMsg = TEXT_FIELD_FORMAT_ERROR
                
            case .phoneNum:
                fieldName = TEXT_PHONE_NUM
                errorMsg = TEXT_FIELD_FORMAT_ERROR
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
