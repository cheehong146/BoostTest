
//
//  ContactListViewModel.swift.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation

struct ContactListViewModel {
    
    // MARK: - Data provider
    func getListOfContacts() -> [Profile] {
        return ProfileService.getProfiles() ?? []
    }
}
