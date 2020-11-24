//
//  GroupPosts.swift
//  CSAPITask
//
//  Created by Aleksandr on 08/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

protocol IGroupPostService {
    func getGroupPosts(ownerID: Int, paging: Paging, completion: @escaping (Result<WallGetResponse, Error>)->())
}

struct GroupPostService: IGroupPostService {
    
    private let apiClient: IAPIClient
    
    init(apiClient: IAPIClient) {
        self.apiClient = apiClient
    }
    
    func getGroupPosts(ownerID: Int, paging: Paging, completion: @escaping (Result<WallGetResponse, Error>) -> ()) {
        apiClient.send(endpoint: WallPostsEndpoint(ownerID: ownerID, paging: paging), responseHandler: completion)
    }
}
