//
//  WallPosts.swift
//  CSAPITask
//
//  Created by Aleksandr on 09/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

protocol IWallPosts {
    var ownerID: Int { get }
    var count: Int { get }
    
    var errorHandler: ((Error) -> ())? { get set }
    var reloadHandler: (() -> ())? { get set }
    
    subscript(index: Int) -> Item { get }
    func fetch()
    func profile(with id: Int) -> Profile?
    func group(with id: Int) -> Group?
    func refresh()
}

class WallPosts: IWallPosts {
    
    var ownerID: Int
    
    var errorHandler: ((Error) -> ())?
    var reloadHandler: (() -> ())?
    
    let wallPostsService: IWallService
    
    var wallPosts: [Item] = []
    var profiles: [Int: Profile] = [:]
    var groups: [Int: Group] = [:]
    
    private var totalCount = 0
    private var paging: Paging
    
    init(ownerID: Int, wallService: IWallService) {
        self.ownerID = ownerID
        self.wallPostsService = wallService
        self.paging = Paging.init(offset: 0, count: 20)
    }
    
    var count: Int {
        get {
            return wallPosts.count
        }
    }
    
    subscript(index: Int) -> Item {
        if (index == wallPosts.count - 10) && (wallPosts.count < totalCount) {
            fetch()
        }
        return wallPosts[index]
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
        wallPostsService.wallGet(ownerID: ownerID, paging: paging) { [weak self](result) in
            guard let self = self else { return }
            switch result {
            case let .success(res):
                self.totalCount = res.response.count
                self.wallPosts.append(contentsOf: res.response.items)
                for profile in res.response.profiles {
                    self.profiles.updateValue(profile, forKey: profile.id)
                }
                for group in res.response.groups {
                    self.groups.updateValue(group, forKey: group.id)
                }
                self.reloadHandler?()
                if self.wallPosts.count < res.response.count {
                    self.paging.offset += res.response.items.count
                }
            case let .error(err):
                self.errorHandler?(err)
            }
        }
    }
    
    func refresh() {
        wallPosts.removeAll()
        profiles.removeAll()
        groups.removeAll()
        paging = Paging.init(offset: 0, count: 20)
        fetch()
    }
}
