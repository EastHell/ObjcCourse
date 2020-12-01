//
//  Factories.swift
//  CSAPITask
//
//  Created by Aleksandr on 26/10/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

class Factories {
    static let shared = Factories()
    
    static var resolveApiClient: IAPIClient = {
        let urlSession = URLSession(configuration: .default)
        urlSession.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let apiClient: IAPIClient = APIClient(requestFactory: resolveRequestFactory, session: urlSession)
        return apiClient
    }()
    
    static var resolveRequestFactory: IRequestFactory = {
        let baseURL = URL(string: "https://api.vk.com/method/")!
        let requestFactory: IRequestFactory = RequestFactory(baseURL: baseURL)
        return requestFactory
    }()
    
    static var resolveWallService: IWallService = {
        let apiClient = Factories.resolveApiClient
        let wallService = WallService(apiClient: apiClient)
        return wallService
    }()
    
    static func wallPosts(ownerID: Int) -> IWallPosts {
        return WallPosts(ownerID: ownerID, wallService: Factories.resolveWallService)
    }
}
