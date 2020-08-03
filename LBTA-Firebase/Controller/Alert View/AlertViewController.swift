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
        let al = UILabel()
        
        al.textColor = .white
        al.font = UIFont(name: "Helvetica-Bold", size: 19)
        al.textAlignment = .center
        
        return al
    }()
    
    private let errorLabel: UILabel = {
        let el = UILabel()
        
        el.textColor = .black
        el.font = UIFont(name: "Helvetica", size: 17)
        el.textAlignment = .center
        el.numberOfLines = 0
      
        return el
    }()
    
    private lazy var dismissButton: UIButton = {
        
        let bb = UIButton(type: .system)
    
        bb.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        bb.tintColor = .white
        bb.clipsToBounds = true
        bb.contentMode = .scaleAspectFill
        bb.setBackgroundImage(#imageLiteral(resourceName: "cross"), for: .normal)
        
        return bb
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
        print("asdasdadas")
        self.dismiss(animated: true, completion: nil)
    }
}

