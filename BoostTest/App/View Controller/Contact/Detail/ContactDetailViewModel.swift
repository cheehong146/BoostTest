//
//  ContactDetailViewModel.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation

enum ContactDetailTableDataRow: Int {
    case firstName = 0
    case lastName = 1
    case email = 2
    case phoneNum = 3
}

enum ContactDetailState {
    case add
    case edit
}

/*
 This structure only support fixed number of row for all the sections
 */
struct ContactDetailTableData {
    var sectionHeader: [String]
    var numOfRowPerSection: Int
    var profile: Profile?
}

class ContactDetailViewModel {
    
    private var state: ContactDetailState!
    private var didUpdateProfile: Bool = false
    
    // tableView related data
    private var tableData: ContactDetailTableData!
    
    init(state: ContactDetailState, profile: Profile? = nil) {
        self.state = state
        self.tableData =  ContactDetailTableData(sectionHeader:[
            TEXT_MAIN_INFORMATION,
            TEXT_SUB_INFOMATION
            ],
        numOfRowPerSection: 2,
        profile: profile
        )
    }
    
    func getProfile() -> Profile? {
        return tableData?.profile
    }
    
    func setProfile(_ profile: Profile?) {
        self.tableData?.profile = profile
    }
    
    func getState() -> ContactDetailState {
        return self.state
    }
    
    func addProfile(_ newProfile: Profile) {
        _ = ProfileService.addProfile(toAdd: newProfile)
    }
    
    func updateProfile(_ editedProfile: Profile)  {
        _ = ProfileService.editProfile(toEdit: editedProfile)
    }
    
    func generateNounceID() -> String {
        return Security.generateNounceID()
    }
    
    func validateProfile(_ profile: Profile) throws {
        try ContactDetailValidator.validateContactDetail(profile)
    }
}

// MARK: - TableView Data provider, edit dynamic header and cell here
extension ContactDetailViewModel {
    
    func getSectionCount() -> Int {
        return tableData.sectionHeader.count
    }
    
    func getSectionTitle(at index: Int) -> String {
        return tableData.sectionHeader[index]
    }
    
    func getNumOfRowInSection(at section: Int) -> Int {
        return tableData.numOfRowPerSection
    }
    /*
     return the describing data label and its' respective value
     */
    func getFields(at index: IndexPath) -> (String, String) {
        
        let rowOffset = index.section * tableData.numOfRowPerSection + index.row
        
        switch rowOffset {
        
        case ContactDetailTableDataRow.firstName.rawValue:
            return (TEXT_FIRST_NAME, tableData.profile?.firstName ?? "")
            
        case ContactDetailTableDataRow.lastName.rawValue:
            return (TEXT_LAST_NAME, tableData.profile?.lastName ?? "")
            
        case ContactDetailTableDataRow.email.rawValue:
            return (TEXT_EMAIL, tableData.profile?.email ?? "")
            
        case ContactDetailTableDataRow.phoneNum.rawValue:
            return (TEXT_PHONE_NUM, tableData.profile?.phone ?? "")
            
        default:
            return("", "")
        }
    }
    
}
