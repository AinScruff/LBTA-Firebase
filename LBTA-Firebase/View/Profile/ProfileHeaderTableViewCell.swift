//
//  ProfileHeaderTableViewCell.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 9/1/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import UIKit
import Firebase
class ProfileHeaderTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    fileprivate var profileImageView: UIImageView = {
        let img = UIImageView()
        
        img.contentMode = .scaleAspectFill
        img.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return img
    }()
    
    fileprivate var nameLabel: UILabel = {
        var nl = UILabel()
        
        nl.font = UIFont(name: "Helvetica-Bold", size: 20)
        nl.textColor = .black
        nl.numberOfLines = 0
        nl.textAlignment = .center
        
        return nl
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        profileImageView.setRounded(borderColor: UIColor.label.cgColor)
    }
}

// MARK: - Constraints
extension ProfileHeaderTableViewCell {
    
    fileprivate func configureCell() {
        addSubview(profileImageView)
        profileImageView.centerAnchor(centerX: centerXAnchor, centerY: centerYAnchor)
        profileImageView.anchor(width: 150, height: 150)
       
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 10, height: 25)
    }
}

// MARK: - Methods
extension ProfileHeaderTableViewCell {
    
    func populateCell(user: User) {
        
        if let url = user.imageURL {
            ImageService.getImage(withURL: url) { image in
                self.profileImageView.image = image
            }
        }
        
        nameLabel.text = user.name
    }
}
