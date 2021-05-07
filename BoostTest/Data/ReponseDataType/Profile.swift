//
//  Profile.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

struct Profile: Decodable {
    var id: String
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
}
