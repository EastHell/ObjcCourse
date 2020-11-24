//
//  WallPosts.swift
//  CSAPITask
//
//  Created by Aleksandr on 08/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

struct Comments: Codable {
    let count: Int
}

struct Likes: Codable {
    let count: Int
}

struct Post: Codable {
    let from_id: Int
    let date: Int
    let text: String
    let comments: Comments
    let likes: Likes
}

struct Profile: Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let photo_50: String
}

struct Group: Codable {
    let id: Int
    let name: String
    let photo_50: String
}

struct WallPosts: Codable {
    let count: Int
    let items: [Post]
    let profiles: [Profile]
    let groups: [Group]
}

struct WallGetResponse: Codable {
    let response: WallPosts
}

struct Paging {
    var offset: Int
    var count: Int
}

struct WallPostsEndpoint: Endpoint {
    
    typealias Response = WallGetResponse
    
    private let ownerID: Int
    private let paging: Paging
    
    init(ownerID: Int, paging: Paging) {
        self.ownerID = ownerID
        self.paging = paging
    }
    
    func requestData() -> RequestData {
        return RequestData(path: "wall.get", method: .get, parameters: ["owner_id": ownerID,
                                                                        "offset": paging.offset,
                                                                        "count": paging.count,
                                                                        "extended": 1], body: .empty)
    }
}
