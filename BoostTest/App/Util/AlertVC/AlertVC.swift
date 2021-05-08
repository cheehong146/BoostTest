//
//  AlertVC.swift
//  BoostTest
//
//  Created by Lan Chee Hong on 08/05/2021.
//

import UIKit

class AlertVC: UIViewController {

    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var label: UILabel!
    
    var viewModel: AlertViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        label.text = viewModel.alertData.message
        noticeView.backgroundColor = viewModel.alertData.alertType == .error ? AlertTheme.error : AlertTheme.notice

        label.sizeToFit()
        
        noticeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNoticeViewPress(_:))))
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        super.beginAppearanceTransition(isAppearing, animated: animated)
        
        if !isAppearing {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.noticeView.frame.origin.y = -(self?.noticeView.frame.size.height ?? 0)
            }
        } else {
            noticeView.frame.origin.y = -noticeView.frame.size.height
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.noticeView.frame.origin.y = 0
            }
        }
    }

    @IBAction func onDismissButtonPress(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onNoticeViewPress(_ gesture: UITapGestureRecognizer) {
        dismiss()
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(from viewController: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        viewController.present(self, animated: true, completion: nil)
    }

}
