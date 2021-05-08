//
//  DialogHelper.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation
import UIKit

class DialogHelper {
    
    public static func showAlert(type: AlertType, errorMessage: String) {
        
        guard !errorMessage.isEmpty else {
            return
        }
        
        let data = AlertData(message: errorMessage, alertType: type)

        let window = UIApplication.shared.keyWindow
        
        if let alertVC = window?.rootViewController?.children.last as? AlertVC {
            DispatchQueue.main.async {
                alertVC.dismiss()
            }
            return
        }
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            if let alertVC = topController as? AlertVC {
                DispatchQueue.main.async {
                    alertVC.dismiss()
                }
                return
            }
            
            let alertVC = AlertVC()
            let vm = AlertViewModel(alertData: data)
            alertVC.viewModel = vm
            
            DispatchQueue.main.async {
                if let navigationController = topController as? UINavigationController, let controller = navigationController.viewControllers.last {
                    alertVC.showAlert(from: controller)
                } else {
                    alertVC.showAlert(from: topController)
                }
            }
        }
    }
}
