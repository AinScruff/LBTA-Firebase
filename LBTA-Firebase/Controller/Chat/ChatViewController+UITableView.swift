//
//  ChatViewController+UITableView.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/17/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import Firebase

// MARK: - UITableView DataSource
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! UserChatTableViewCell
        
        cell.populateCell(with: userArray[indexPath.row])
        
        return cell
    }
    
}

// MARK: - UITableView Delegate
extension ChatViewController: UITableViewDelegate {
    
    
}
