//
//  UserChatTableViewCell.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 8/17/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit

class UserChatTableViewCell: UITableViewCell {
    
    // MARK: - Properties
 
    // MARK: - View Elements
    var profileImageView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "textformat.size"))
        
        img.contentMode = .scaleAspectFill
        img.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return img
    }()
    
    var nameLabel: UILabel = {
        var nl = UILabel()
        
        nl.font = UIFont(name: "Helvetica", size: 17)
        nl.textColor = .black
        nl.numberOfLines = 0
     
        return nl
    }()
    
    var chatLabel: UILabel = {
        var cl = UILabel()
        
        cl.font = UIFont(name: "Helvetica", size: 13)
        cl.textColor = .systemGray2
        cl.numberOfLines = 0
        
        return cl
    }()
    
   
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        nameLabel.sizeToFit()
        chatLabel.sizeToFit()
        profileImageView.setRounded(borderColor: UIColor.black.cgColor)
    }
    
}
// MARK: - Constraints
extension UserChatTableViewCell {
    
    func configureCell() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, chatLabel])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = .zero
        
        addSubview(stackView)
        addSubview(profileImageView)
        
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeading: 5, paddingBottom: 5, width: 50)
        
        stackView.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 5, paddingBottom: 5, paddingTrailing: 5)
       
    }

    
}
