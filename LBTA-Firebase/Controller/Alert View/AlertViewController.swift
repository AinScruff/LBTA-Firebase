//
//  AlertViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 6/16/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    
    // MARK: - Properties

    private let alertViewHeight: CGFloat = 150
    
    var titleMessage: String? {
        didSet {
            guard let message = titleMessage else {
                return
            }
            alertLabel.text = message
        }
    }
    
    var errorMessage: String? {
        didSet {
            guard let err = errorMessage else {
                return
            }
            
            errorLabel.text = "\(err)\nPlease try again."
        }
    }
    
    // MARK: - View Elements

    private let alertView = UIView()
    
    private let navBarView = UIView()
    
    private let alertLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 19)
        label.textAlignment = .center
        
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
      
        return label
    }()
    
    private lazy var dismissButton: UIButton = {
        
        let button = UIButton(type: .system)
    
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.tintColor = .white
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        button.setBackgroundImage(#imageLiteral(resourceName: "cross"), for: .normal)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
}

// MARK: - Constraints
extension AlertViewController {
    
    private func setUpView() {
        let blackBackground = UIColor.black.withAlphaComponent(0.50)
        view.backgroundColor = blackBackground
        
        view.addSubview(alertView)
        alertView.centerAnchor(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        alertView.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingLeading: 50, paddingTrailing: 50, height: alertViewHeight)
        alertView.backgroundColor = .white
        
        alertView.addSubview(navBarView)
        navBarView.anchor(top: alertView.topAnchor, leading: alertView.leadingAnchor, trailing: alertView.trailingAnchor, height: alertViewHeight / 2)
        navBarView.backgroundColor = .systemRed
        
        alertView.addSubview(dismissButton)
        dismissButton.anchor(top: alertView.topAnchor, trailing: alertView.trailingAnchor, paddingTop: 10, paddingTrailing: 10, width: 30, height: 30)
        
        navBarView.addSubview(alertLabel)
        alertLabel.centerAnchor(centerX: navBarView.centerXAnchor, centerY: navBarView.centerYAnchor)
        alertLabel.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, height: 40)
    
        alertView.addSubview(errorLabel)
        alertView.verticalSpacing(topView: navBarView, bottomView: errorLabel, constant: 0)
        errorLabel.anchor(leading: alertView.leadingAnchor, bottom: alertView.bottomAnchor, trailing: alertView.trailingAnchor)
       
    }

}

// MARK: - Methods
extension AlertViewController {

    @objc private func dismissView(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

