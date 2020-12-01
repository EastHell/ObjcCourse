//
//  WallService.swift
//  CSAPITask
//
//  Created by Aleksandr on 26/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

protocol IWallService {
    func wallGet(ownerID: Int, paging: Paging, completion: @escaping (Result<WallGetResult, Error>)->())
    func wallPost(ownerID: Int, message: String, completion: @escaping (Result<WallPostResult, Error>)->())
}

struct WallService: IWallService {
    
    private let apiClient: IAPIClient
    
    init(apiClient: IAPIClient) {
        self.apiClient = apiClient
    }
    
    func wallGet(ownerID: Int, paging: Paging, completion: @escaping (Result<WallGetResult, Error>) -> ()) {
        apiClient.send(endpoint: WallGetEndpoint(ownerID: ownerID, paging: paging), responseHandler: completion)
    }
    
    func wallPost(ownerID: Int, message: String, completion: @escaping (Result<WallPostResult, Error>) -> ()) {
        apiClient.send(endpoint: WallPostEndpoint(ownerID: ownerID, message: message), responseHandler: completion)
    }
}
