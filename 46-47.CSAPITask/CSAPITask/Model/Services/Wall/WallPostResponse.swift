//
//  WallPostResponse.swift
//  CSAPITask
//
//  Created by Aleksandr on 26/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

struct WallPostResponse: Codable {
    let post_id: Int
}

struct WallPostResult: Codable {
    let response: WallPostResponse
}

struct WallPostEndpoint: Endpoint {
    
    typealias Response = WallPostResult
    
    private let ownerID: Int
    private let message: String
    
    init(ownerID: Int, message: String) {
        self.ownerID = ownerID
        self.message = message
    }
    
    func requestData() -> RequestData {
        return RequestData(path: "wall.post", method: .post, parameters: ["owner_id": ownerID,
                                                                          "message": message], body: .empty)
    }
}
