//
//  ProfileService.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation

// MARK: - ProfileServiceInterface
protocol ProfileServiceInterface {
    static func getProfiles() -> [Profile]?
    static func editProfile(toEdit: Profile) -> Bool
    static func deleteProfile(id: String)
}

// MARK: - ProfileService
struct ProfileService: ProfileServiceInterface {
    
    static let dataSourceFileName = "data"
    static let dataSourceFileExtension = "json"
    
    // MARK: - Services
    static func getProfiles() -> [Profile]? {
        return loadJson()
    }
    
    static func addProfile(toAdd: Profile) -> Bool {
        guard var profiles = loadJson() else { return false }
        
        profiles.append(toAdd)
        return writeJson(profiles: profiles)
    }
    
    /*
     Return true on successful edit and false otherwise
     */
    static func editProfile(toEdit: Profile) -> Bool {
        guard var profiles = loadJson() else { return false }
    
        for i in 0..<profiles.count {
            if profiles[i].id == toEdit.id && (
                profiles[i].firstName != toEdit.firstName ||
                    profiles[i].lastName != toEdit.lastName ||
                    profiles[i].email != toEdit.email ||
                    profiles[i].phone != toEdit.phone) {
                profiles[i] = toEdit
                return writeJson(profiles: profiles)
            }
        }
        return false
    }
    
    static func deleteProfile(id: String) {
        // TODO
    }
    
    /*
     Return true on successful write and false otherwise
     */
    private static func writeJson(profiles: [Profile]?) -> Bool {
            guard let profiles = profiles else { return false }
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let orderJsonData = try! encoder.encode(profiles)
            return FileManager.shared.writeTo(data: orderJsonData, fileName: dataSourceFileName, fileNameExtension: dataSourceFileExtension)
    }
    
    private static func loadJson() -> [Profile]? {
        guard let data = FileManager.shared.readFrom(fileName: dataSourceFileName, fileNameExtension: dataSourceFileExtension) else { return nil }
        let decoder = JSONDecoder()
        do {
        let jsonData = try decoder.decode([Profile].self, from: data)
            print("😀 \(jsonData.count)")
        return jsonData
        } catch _ {
            // TODO toast some error
        }
        return nil
    }
}
