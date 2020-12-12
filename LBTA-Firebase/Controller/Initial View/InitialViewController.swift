//
//  InitialViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 6/4/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import Firebase

class InitialViewController: UIViewController {

    // MARK: - Properties
    
    let validation = LogInValidationService.shared
    let services = UserService.shared
    
    let authRef = Constants.API.AUTH_REF

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var vc: UIViewController
        
        if authRef.currentUser != nil {
            vc = TabBarViewController()
        } else {
            vc = LogInViewController(validation: validation, userService: services)
        }
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    // MARK: - Methods
    
    private func login(_ email: String, _ password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                print("Something went Wrong")
            } else {
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }
        }
    }
}
