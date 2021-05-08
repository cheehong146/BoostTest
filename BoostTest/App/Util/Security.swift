//
//  Security.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation
class Security {
    // TODO, check agaist the file for duplicate generated ID before adding to ensure unique value
    
    static let idLength = 24
    static func generateNounceID() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<idLength).map{ _ in letters.randomElement()! })
    }
}
