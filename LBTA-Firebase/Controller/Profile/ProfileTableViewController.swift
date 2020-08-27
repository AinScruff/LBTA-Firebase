//
//  ProfileTableViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/28/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class ProfileTableViewController: UITableViewController {
    
    // MARK: - Properties
    let keychain = Constants.Keys.KEYCHAIN_REF
    let auth = Constants.API.AUTH_REF
    
    let cellId = "cell"
    
    // MARK: - View Elements
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = "aDIUAHSFIUHAS"
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            
            let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
                do {
                    try self.auth.signOut()
                    self.keychain.clear()
                    self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
                } catch {
                    print("Err")
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            showErrorView(actions: [signOutAction, cancelAction])
            
        }
    }
    
    // MARK: - Methods
    
    fileprivate func showErrorView(actions: [UIAlertAction]) {
        let alert = UIAlertController(title: "Sign Out", message: nil, preferredStyle: .actionSheet)
        
        for action in actions {
            alert.addAction(action)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Constraints
extension ProfileTableViewController {
    
    fileprivate func configureTableView() {
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
