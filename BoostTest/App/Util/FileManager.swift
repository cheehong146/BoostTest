//
//  FileManager.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation

class FileManager {
    
    static var shared = FileManager()
    
    func writeTo(data: Data, fileName: String, fileNameExtension: String) -> Bool {
        do {
            if let url = Bundle.main.url(forResource: fileName, withExtension: fileNameExtension) {
                try data.write(to: url)
                return true
            }
        } catch {
            print("error:\(error)")
        }
        return false
    }
    
    func readFrom(fileName: String, fileNameExtension: String) -> Data? {
        do {
            if let url = Bundle.main.url(forResource: fileName, withExtension: fileNameExtension) {
                let data = try Data(contentsOf: url)
                return data
            }
        } catch {
            print("error:\(error)")
        }
        return nil
    }
}
