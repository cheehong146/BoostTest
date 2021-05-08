//
//  AlertViewModel.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation

enum AlertType {
    case error
    case notice
}

struct AlertData {
    var message: String
    var alertType: AlertType
}

class AlertViewModel {
    
    var alertData: AlertData
    
    init(alertData: AlertData) {
        self.alertData = alertData
    }
    
    
}
