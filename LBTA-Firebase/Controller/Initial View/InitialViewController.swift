//
//  InitialViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 6/4/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit

class InitialViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        viewControllers = [LogInViewController()]
        
    }
    
}
