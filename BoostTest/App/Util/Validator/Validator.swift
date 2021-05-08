//
//  Validator.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation

struct Validator {
    
    public static func isValidName(_ str: String?) -> Bool {
        guard let firstName = str else { return false }
        return !firstName.isEmpty
    }
    
    public static func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

       let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       return emailPred.evaluate(with: email)
    }
    
    public static func isValidPhoneNum(_ phoneNum: String?) -> Bool {
        guard let phoneNum = phoneNum else { return false }
        
        _ = "(892) 456-3603"
        let phoneNumRegEx = "^\\(\\d{3}\\) \\d{3}.\\d{4}$"

       let phoneNumPred = NSPredicate(format:"SELF MATCHES %@", phoneNumRegEx)
       return phoneNumPred.evaluate(with: phoneNum)
    }
}
