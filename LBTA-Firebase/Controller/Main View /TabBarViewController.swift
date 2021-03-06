//
//  TabBarViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/3/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Properties
    
    let userService = UserService.shared
    let msgService = MessageService.shared
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = createTabBarItem(tabBarTitle: "Chat", vc: ChatViewController(userService: userService, msgService: msgService), tabBarImage: "chat")
        let vc2 = createTabBarItem(tabBarTitle: "Profile", vc: ProfileTableViewController(userService: userService), tabBarImage: "user")
        viewControllers = [vc1, vc2]
    }
    
}

// MARK: - Private Methods
extension TabBarViewController {
    
    private func createTabBarItem(tabBarTitle: String, vc: UIViewController, tabBarImage: String) -> UINavigationController{
        
        let navCont = UINavigationController(rootViewController: vc)
        navCont.tabBarItem.title = tabBarTitle
        navCont.tabBarItem.image = UIImage(named: tabBarImage)
        
        return navCont
    }
}
