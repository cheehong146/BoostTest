//
//  Routing.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import Foundation
import UIKit

extension UIWindow {
    
    func changeRootViewController(to desiredViewController: UIViewController) {
        
        if rootViewController != nil,
            let snapshot = self.snapshotView(afterScreenUpdates: true) {
            
            desiredViewController.view.addSubview(snapshot)
            
            for view in subviews {
                view.removeFromSuperview()
            }
            
            rootViewController = desiredViewController
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    
                    snapshot.layer.opacity = 0
                    
            }, completion: { (finished) in
                snapshot.removeFromSuperview()
            })
        } else {
            rootViewController = desiredViewController
        }
    }
}

extension UIViewController {
    
    func changeRootViewController(to desiredViewController: UIViewController) {
        
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
            return
        }
        
        window.changeRootViewController(to: desiredViewController)
    }
    
    func pushOnNVC(animated: Bool = true, vc: UIViewController) {
        guard let nvc = self.navigationController else {
            return
        }
        nvc.pushViewController(vc, animated: animated)
    }
    
    func popFromNVC(animated: Bool = true) {
        guard let nvc = self.navigationController else {
            return
        }
        nvc.popViewController(animated: animated)
    }
}

extension UIWindow {
    
    func openContactList() {
        let vc = ContactListVC()
        self.changeRootViewController(to: vc)
    }
}

extension UIViewController {
    
    func openAddContact(fromVC: ContactListVC) {
        let vc = ContactDetailVC()
        let vm = ContactDetailViewModel(state: .add)
        vc.viewModel = vm
        vc.delegate = fromVC
        self.pushOnNVC(vc: vc)
    }
    
    func openEditContact(profile: Profile) {
        let vc = ContactDetailVC()
        let vm = ContactDetailViewModel(state: .edit, profile: profile)
        vc.viewModel = vm
        self.pushOnNVC(vc: vc)
    }
}
