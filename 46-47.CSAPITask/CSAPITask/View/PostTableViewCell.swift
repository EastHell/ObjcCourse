//
//  PostTableViewCell.swift
//  CSAPITask
//
//  Created by Aleksandr on 17/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var likesCountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var commentsCountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var postTextLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var likeImageView: UIImageView = {
        let img = UIImage(named: "like")
        let imgView = UIImageView(image: img)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private var commentImageView: UIImageView = {
        var img = UIImage(named: "comment")
        var imgView = UIImageView(image: img)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var avatarImageView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 25
        return imgView
    }()
    
    var dateLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 129.0/255.0, green: 129.0/255.0, blue: 129.0/255.0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 33.0/255.0, green: 69.0/255.0, blue: 114.0/255.0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var containerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 232.0/255.0, green: 236.0/255.0, blue: 233.0/255.0, alpha: 1)
        contentView.backgroundColor = UIColor(red: 232.0/255.0, green: 236.0/255.0, blue: 233.0/255.0, alpha: 1)
        
        contentView.addSubview(containerView)
        containerView.configureVKStyle()
        
        containerView.addSubview(avatarImageView)
        
        avatarImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: containerView.readableContentGuide.topAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: containerView.readableContentGuide.leadingAnchor).isActive = true
        
        containerView.addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        containerView.addSubview(dateLabel)
        
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        containerView.addSubview(postTextLabel)
        
        postTextLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8).isActive = true
        postTextLabel.leftAndRightToSuperview(insets: 8)
        
        containerView.addSubview(commentImageView)
        
        commentImageView.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 16).isActive = true
        commentImageView.bottomToSuperview(inset: -8)
        commentImageView.leadingAnchor.constraint(equalTo: postTextLabel.leadingAnchor, constant: 0).isActive = true
        
        containerView.addSubview(commentsCountLabel)

        commentsCountLabel.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 16).isActive = true
        commentsCountLabel.bottomToSuperview(inset: -8)
        commentsCountLabel.leadingAnchor.constraint(equalTo: commentImageView.trailingAnchor, constant: 8).isActive = true
        
        containerView.addSubview(likeImageView)
        
        likeImageView.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 16).isActive = true
        likeImageView.bottomToSuperview(inset: -8)
        likeImageView.leadingAnchor.constraint(equalTo: commentsCountLabel.trailingAnchor, constant: 24).isActive = true
        
        containerView.addSubview(likesCountLabel)

        likesCountLabel.topAnchor.constraint(equalTo: postTextLabel.bottomAnchor, constant: 16).isActive = true
        likesCountLabel.bottomToSuperview(inset: -8)
        likesCountLabel.leadingAnchor.constraint(equalTo: likeImageView.trailingAnchor, constant: 8).isActive = true
        likesCountLabel.trailingAnchor.constraint(greaterThanOrEqualTo: postTextLabel.trailingAnchor, constant: 8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
