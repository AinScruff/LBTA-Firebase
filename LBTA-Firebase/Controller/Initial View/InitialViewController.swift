//
//  InitialViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 6/4/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class InitialViewController: UIViewController {

    // MARK: - Properties
    
    let validation = LogInValidationService.shared
    let services = ServicesAPI.shared
    let keyRef = Constants.Keys.KEYCHAIN_REF
      
    let emailKey = Constants.Keys.EMAIL
    let passwordKey = Constants.Keys.PASSWORD
  
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
       if let email = keyRef.get(emailKey), let password = keyRef.get(passwordKey) {
           login(email, password)
        } else {
            let vc = LogInViewController(validation: validation)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
        
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
