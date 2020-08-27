//
//  Utilities.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 6/16/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit

class Utilities {
    
    // Show Error Message
    static func showErrorView(title: String, message: String) -> UIViewController {
        let vc = AlertViewController()
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.titleMessage = title
        vc.errorMessage = message
    
        return vc
    }
    
}
