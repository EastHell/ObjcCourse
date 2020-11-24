//
//  GroupPostsContainer.swift
//  CSAPITask
//
//  Created by Aleksandr on 09/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

protocol IGroupPosts {
    var count: Int { get }
    subscript(index: Int) -> Post { get }
    func fetch()
    var errorHandler: ((Error) -> ())? { get set }
    var reloadHandler: (() -> ())? { get set }
    func profile(with id: Int) -> Profile?
    func group(with id: Int) -> Group?
}

class GroupPosts: IGroupPosts {
    
    var errorHandler: ((Error) -> ())?
    var reloadHandler: (() -> ())?
    
    let groupPostsService: GroupPostService
    
    var groupPosts: [Post] = []
    var profiles: [Int: Profile] = [:]
    var groups: [Int: Group] = [:]
    var ownerID: Int
    private var paging: Paging
    
    var count: Int {
        get {
            return groupPosts.count
        }
    }
    
    init(ownerID: Int, groupPostsService: GroupPostService) {
        self.ownerID = ownerID
        self.groupPostsService = groupPostsService
        self.paging = Paging.init(offset: 0, count: 20)
    }
    
    subscript(index: Int) -> Post {
        if index == groupPosts.count - 10 {
            fetch()
        }
        return groupPosts[index]
    }
    
    func profile(with id: Int) -> Profile? {
        return profiles[id]
    }
    
    func group(with id: Int) -> Group? {
        if id < 0 {
            return groups[abs(id)]
        }
        return groups[id]
    }
    
    func fetch() {
        groupPostsService.getGroupPosts(ownerID: ownerID, paging: paging) { [weak self](result) in
            guard let self = self else { return }
            switch result {
            case let .success(res):
                self.groupPosts.append(contentsOf: res.response.items)
                for profile in res.response.profiles {
                    self.profiles.updateValue(profile, forKey: profile.id)
                }
                for group in res.response.groups {
                    self.groups.updateValue(group, forKey: group.id)
                }
                self.reloadHandler?()
                if self.groupPosts.count < res.response.count {
                    self.paging.offset += res.response.items.count
                }
            case let .error(err):
                self.errorHandler?(err)
            }
        }
    }
}
