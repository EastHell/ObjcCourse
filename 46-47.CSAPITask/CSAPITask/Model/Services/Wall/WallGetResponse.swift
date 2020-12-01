//
//  WallGetResponse.swift
//  CSAPITask
//
//  Created by Aleksandr on 26/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

struct Comments: Codable {
    let count: Int
}

struct Likes: Codable {
    let count: Int
}

struct Item: Codable {
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

struct WallGetResponse: Codable {
    let count: Int
    let items: [Item]
    let profiles: [Profile]
    let groups: [Group]
}

struct WallGetResult: Codable {
    let response: WallGetResponse
}

struct Paging {
    var offset: Int
    var count: Int
}

struct WallGetEndpoint: Endpoint {
    
    typealias Response = WallGetResult
    
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
