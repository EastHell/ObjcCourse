//
//  GroupPostsTableViewController.swift
//  CSAPITask
//
//  Created by Aleksandr on 20/10/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import UIKit
import Kingfisher

class GroupPostsTableViewController: UITableViewController {
    
    var groupPosts: IGroupPosts
    
    init(groupPosts: IGroupPosts) {
        self.groupPosts = groupPosts
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupPosts.errorHandler = { [weak self](error) in
            switch error {
            case let err as NetworkError where [.noAccessToken, .expiredAccessToken].contains(err):
                let lvc = LoginViewController()
                self?.present(lvc, animated: true, completion: nil)
            default:
                print("Error occured: \(error.localizedDescription)")
            }
        }
        
        groupPosts.reloadHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor(red: 59.0/255.0, green: 97.0/255.0, blue: 151.0/255.0, alpha: 1)
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        groupPosts.fetch()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        let post = groupPosts[indexPath.row]
        
        cell.postTextLabel.text = post.text
        cell.commentsCountLabel.text = "\(post.comments.count)"
        cell.likesCountLabel.text = "\(post.likes.count)"
        let date = DateFormatter.dateAndTimeFormatter.string(from: Date(timeIntervalSince1970: Double(post.date)))
        cell.dateLabel.text = date
        
        var avatarURL: URL?
        var name: String
        if post.from_id < 0 {
            let group = groupPosts.group(with: post.from_id)
            avatarURL = URL(string: group?.photo_50 ?? "https://vk.com/images/camera_c.gif")
            name = group?.name ?? ""
        } else {
            let profile = groupPosts.profile(with: post.from_id)
            avatarURL = URL(string: profile?.photo_50 ?? "https://vk.com/images/camera_c.gif")
            name = "\(profile?.first_name ?? "") \(profile?.last_name ?? "")"
        }
        cell.avatarImageView.kf.setImage(with: avatarURL)
        cell.nameLabel.text = name
        
        return cell
    }
}
