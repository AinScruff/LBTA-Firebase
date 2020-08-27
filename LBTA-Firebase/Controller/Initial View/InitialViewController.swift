//
//  InitialViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 6/4/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import Firebase

class InitialViewController: UINavigationController {

    // MARK: - Properties
    var vc = UIViewController()
    let validation = LogInValidationService.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        // Log in user using keychain
        viewControllers = [LogInViewController(validation: validation)]
    }
    
    // MARK: - Methods
}
