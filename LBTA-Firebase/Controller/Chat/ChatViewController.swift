//
//  ChatViewController.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/3/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    // MARK: - Properties
    let cellId = "cell"
    let services = ServicesAPI()
    var user = [User]()
    // MARK: - View Elements
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.backgroundColor = .white
        
        return table
    }()
    
    let tableFooter: UIView = {
        let tf = UIView(frame: .zero)
        
        tf.backgroundColor = .white
        
        return tf
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
        fetchUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.tableFooterView = tableFooter
    }
    
}


// MARK: - Constraints
extension ChatViewController {
    
    fileprivate func configureNavBar() {
        navigationItem.title = "Chat"
        
    }
    
    fileprivate func configureTableView() {
        view.addSubview(tableView)
        tableView.pinSuperView()
        tableView.rowHeight = 65
        
        setTableViewDelegates()
        registerCells()
    }
    
    fileprivate func setTableViewDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    fileprivate func registerCells() {
        tableView.register(UserChatTableViewCell.self, forCellReuseIdentifier: cellId)
    }
  
}

// MARK: - Methods
extension ChatViewController {

    fileprivate func fetchUsers() {
        services.fetchFriendData { (user) in
            self.user.append(user)
            
            self.tableView.reloadData()
        }
    }
}
