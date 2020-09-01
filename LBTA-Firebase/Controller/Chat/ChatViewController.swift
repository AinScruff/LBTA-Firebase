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
    let userID = Constants.API.AUTH_REF.currentUser?.uid
    var user = [User]()
    
    let services: UserService
    
    init(services: UserService) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Elements
    let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.backgroundColor = .white
        
        return table
    }()
    
    fileprivate let tableFooter: UIView = {
        let tf = UIView(frame: .zero)
        
        tf.backgroundColor = .white
        
        return tf
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
        fetchUsers(userID)
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
    
    fileprivate func fetchUsers(_ userID: String?) {
        services.fetchFriendData(userID: userID) { (user) in
            self.user.append(user)

            self.tableView.reloadData()
        }
    }
}
