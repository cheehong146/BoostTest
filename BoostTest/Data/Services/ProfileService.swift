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
    
    // MARK: - Services
    static func getProfiles() -> [Profile]? {
        return loadJson()
    }
    
    /*
     Return true on successful edit and false otherwise
     */
    static func editProfile(toEdit: Profile) -> Bool {
        
        guard var profiles = loadJson() else { return false }
    
        for i in 0..<profiles.count {
            if profiles[i].id == toEdit.id {
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
        do {
            guard let profiles = profiles else { return false }
            let jsonData: NSData
            jsonData = try JSONSerialization.data(withJSONObject: profiles, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            print("json string = \(jsonString)")
            return true
        } catch _ {
            return false
        }
    }
    
    private static func loadJson() -> [Profile]? {
        if let url = Bundle.main.url(forResource: dataSourceFileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Profile].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
