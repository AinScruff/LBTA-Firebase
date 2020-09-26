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
    fileprivate var profileImageView: UIImageView = {
        let img = UIImageView(image: UIImage(systemName: "textformat.size"))
        
        img.contentMode = .scaleAspectFill
        img.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return img
    }()
    
    fileprivate var nameLabel: UILabel = {
        var nl = UILabel()
        
        nl.font = UIFont(name: "Helvetica", size: 17)
        nl.textColor = .black
        nl.numberOfLines = 0
     
        return nl
    }()
    
    fileprivate var chatLabel: UILabel = {
        var cl = UILabel()
        
        cl.font = UIFont(name: "Helvetica", size: 13)
        cl.textColor = .systemGray2
        cl.numberOfLines = 0
        
        return cl
    }()
    
    fileprivate var dateLabel: UILabel = {
        var dl = UILabel()
        
        dl.font = UIFont(name: "Helvetica", size: 13)
        dl.textColor = .systemGray2
        dl.numberOfLines = 0
        
        return dl
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
        
        nameLabel.sizeToFit()
        chatLabel.sizeToFit()
        profileImageView.setRounded(borderColor: UIColor.black.cgColor)
    }

}
// MARK: - Constraints
extension UserChatTableViewCell {
    
    fileprivate func configureCell() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, chatLabel])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = .zero
        
        addSubview(stackView)
        addSubview(dateLabel)
        addSubview(profileImageView)
      
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeading: 5, paddingBottom: 5, width: 50)
        
        dateLabel.anchor(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTrailing: 5, width: 50)
        
        stackView.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: bottomAnchor, trailing: dateLabel.leadingAnchor, paddingTop: 5, paddingLeading: 5, paddingBottom: 5)
    }
    
}
// MARK: - Methods
extension UserChatTableViewCell {
    
    func populateCell(with userMessage: UserMessage) {
        
        if let imageURL = userMessage.user.imageURL {
            ImageService.getImage(withURL: imageURL) { image in
                self.profileImageView.image = image
            }
        }
        
        self.nameLabel.text = userMessage.user.name
        
        if let latestMsg  = userMessage.latestMessage {
            self.chatLabel.text = latestMsg.message
            self.dateLabel.text = checkDate(latestMsg.dateSent)
        } else {
            self.chatLabel.text = "Chat with your friend now!"
        }
            
    }
    

    fileprivate func checkDate(_ date: Date) -> String {
        
        if isSameDate(date) {
            return date.getTime()
        } else {
            let formatter = DateFormatter()
            
            formatter.dateStyle = .short

            return formatter.string(from: date)
        }
    }

    fileprivate func isSameDate(_ date: Date) -> Bool {
        let today = Date()

        let diff = Calendar.current.dateComponents([.month], from: date, to: today)
        
        return diff.day == 0 ? true : false
    }

}



// Convert date to String
// convert date to local time
// Compare date == today show time else show date
