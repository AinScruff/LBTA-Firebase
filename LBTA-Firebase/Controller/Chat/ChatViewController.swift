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
    
    var userDict = [String : UserMessage]()
    var userArray = [UserMessage]()
    
    // MARK: - View Elements
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    fileprivate let tableFooter: UIView = {
        let tableFooter = UIView(frame: .zero)
        
        tableFooter.backgroundColor = .white
        
        return tableFooter
    }()
    
    // MARK: - Initialization
    
    let userService: UserService
    let msgService: MessageService
    
    init(userService: UserService, msgService: MessageService) {
        self.userService = userService
        self.msgService = msgService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        if let uid = userID {
            msgService.fetchUserChat(currUserID: uid) { [weak self] userMessage in
                
                if let userMessage = userMessage {
                    self?.userDict.updateValue(userMessage, forKey: userMessage.user.name!)
                    self?.userArray.append(userMessage)
                }
                
                self?.tableView.reloadData()
            }
        } else {
            self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    fileprivate func observeIncomingMessages(_ userID: String) {
        
        
    }
}

// CHECK INTERNET CONNECTION https://www.youtube.com/watch?v=uEJzc81oCk4
