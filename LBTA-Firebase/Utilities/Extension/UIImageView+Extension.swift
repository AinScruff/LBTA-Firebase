//
//  UIImageView+Extension.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 7/15/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setRounded(borderColor: CGColor?) {
        
        if let _ = borderColor {
            self.layer.borderWidth = 1
            self.layer.borderColor = borderColor
        }
        
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
