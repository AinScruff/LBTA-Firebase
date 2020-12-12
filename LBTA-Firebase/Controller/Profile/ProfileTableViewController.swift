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
    let defaults = UserDefaults.standard
    let keychain = Constants.Keys.KEYCHAIN_REF
    let auth = Constants.API.AUTH_REF
    
    var user = User()
    var options = ["My Profile", "Sign Out"]
    
    // MARK: - View Elements
    
    let headerCellID = "headerCell"
    let cellId = "cell"
    
    fileprivate let tableFooter: UIView = {
        let tableFooter = UIView(frame: .zero)
        
        tableFooter.backgroundColor = .white
        
        return tableFooter
    }()
    
    // MARK: - Initialization
    
    let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        getUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.tableFooterView = tableFooter
    }
    
}

// MARK: - Constraints
extension ProfileTableViewController {
    
    fileprivate func configureTableView() {
        navigationItem.title = "Profile"
        registerCells()
    }
    
    fileprivate func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ProfileHeaderTableViewCell.self, forCellReuseIdentifier: headerCellID)
    }
}

// MARK: - UITableView DataSource
extension ProfileTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellID, for: indexPath) as! ProfileHeaderTableViewCell
            
            cell.populateCell(user: user)
            cell.isUserInteractionEnabled = false
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            
            
            cell.textLabel?.text = options[indexPath.row - 1]
           
            return cell
        }
        
    }
    
}

// MARK: - UITableView Delegate
extension ProfileTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 2 {
            
            let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
                do {
                    try self.auth.signOut()
                    UserProfileCache.remove()
                    self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
                } catch {
                    print("Err")
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            showErrorView(actions: [signOutAction, cancelAction])
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        } else {
            return UITableView.automaticDimension
        }
    }
}

// MARK: - Methods
extension ProfileTableViewController {
    
    fileprivate func showErrorView(actions: [UIAlertAction]) {
        let alert = UIAlertController(title: "Sign Out", message: nil, preferredStyle: .actionSheet)
        
        for action in actions {
            alert.addAction(action)
        }

        // Added this to fix Apple Bug. More info: https://stackoverflow.com/questions/55653187/swift-default-alertviewcontroller-breaking-constraints
        alert.view.addSubview(UIView())
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func getUser() {
            
        if let uid = Constants.API.AUTH_REF.currentUser?.uid {
            if let savedUser = UserProfileCache.get() {
                user = savedUser
            } else {
                userService.fetchUserData(userID: uid) { user in
                    
                    if let user = user {
                        self.user = user
                    }
                    self.tableView.reloadData()
                }
            }
        } else {
            self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }
}
// ADD LISTENER IN CASE IF UPDATE USER
