//
//  ContactDetailViewModel.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation

enum ContactDetailState {
    case add
    case edit
}

struct ContactDetailTableData {
    var sections: [Section]
    
    struct Section {
        var title: String?
        var fields: [String: String]
    }
}

class ContactDetailViewModel {
    
    private var state: ContactDetailState!
    private var profile: Profile?
    private var didUpdateProfile: Bool = false
    
    // tableView related data
    private var tableData: ContactDetailTableData?
    
    init(state: ContactDetailState) {
        self.state = state
    }
    
    func getProfile() -> Profile? {
        return profile
    }
    
    func setProfile(_ profile: Profile?) {
        self.profile = profile
    }
    
    func getState() -> ContactDetailState {
        return self.state
    }
    
    func updateProfile(_ editedProfile: Profile)  {
        switch state {
        case .add:
            _ = ProfileService.addProfile(toAdd: editedProfile)
        case .edit:
            _ = ProfileService.editProfile(toEdit: editedProfile)
        default:
            return
        }
    }
    
    func generateNounceID() -> String {
        return Security.generateNounceID()
    }
}

// MARK: - TableView Data provider, edit dynamic header and cell here
extension ContactDetailViewModel {
    
    /*
     init dynamic section and it's field here
     */
    func getTableData() -> ContactDetailTableData {
        if tableData == nil {
            
            let firstSection = ContactDetailTableData.Section(title: "Main Information", fields: [
                "First Name": self.profile?.firstName ?? "",
                "Last Name": self.profile?.lastName ?? ""
            ])
            let secondSection = ContactDetailTableData.Section(title: "Sub Information", fields: [
                "Email": self.profile?.email ?? "",
                "Phone": self.profile?.phone ?? ""
            ])
            self.tableData = ContactDetailTableData(sections: [firstSection, secondSection])
        }
        return self.tableData!
    }
    
    func getSectionCount() -> Int {
        return getTableData().sections.count
    }
    
    func getSectionTitle(at index: Int) -> String {
        return getTableData().sections[index].title ?? "-"
    }
    
    func getNumOfRowInSection(at section: Int) -> Int {
        return getTableData().sections[section].fields.count
    }
    /*
     return the describing data label and its' respective value
     */
    func getFields(at index: IndexPath) -> (String, String) {
        let dict = getTableData().sections[index.section].fields
        
        let dictionaryIndex =  dict.index(dict.startIndex, offsetBy: index.row)
        
        let key = dict[dictionaryIndex].key
        let val = dict[key]
        return (key, val ?? "")
    }
    
}
