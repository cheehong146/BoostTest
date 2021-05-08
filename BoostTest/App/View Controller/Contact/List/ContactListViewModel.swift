
//
//  ContactListViewModel.swift.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation

class ContactListViewModel {
    
    var listOfContacts: [Profile]?
    
    // MARK: - Data provider
    func getListOfContacts() -> [Profile] {
        if listOfContacts == nil {
            self.listOfContacts = ProfileService.getProfiles() ?? []
        }
        return listOfContacts ?? []
    }
}
