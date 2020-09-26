//
//  Date+Extension.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 9/15/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation

extension Date {
    
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
 
    func getTime() -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "h:mm a"
        
        return formatter.string(from: self)
    }
}
