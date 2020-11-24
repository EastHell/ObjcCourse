//
//  APIClient.swift
//  CSAPITask
//
//  Created by Aleksandr on 26/10/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

protocol Endpoint {
    associatedtype Response: Codable
    func requestData() -> RequestData
}

enum Result<T, Error> {
    case success(T)
    case error(Error)
}

protocol IAPIClient {
    func send<T: Endpoint>(endpoint: T, responseHandler: @escaping (Result<T.Response, Error>) -> ())
}

struct APIClient {
    private let requestFactory: IRequestFactory
    private let session: URLSession
    
    init(requestFactory: IRequestFactory,
         session: URLSession) {
        self.requestFactory = requestFactory
        self.session = session
    }
}

extension APIClient: IAPIClient {
    func send<T>(endpoint: T, responseHandler: @escaping (Result<T.Response, Error>) -> ()) where T : Endpoint {
        let urlRequest: URLRequest
        
        let responseHandler: (Result<T.Response, Error>) -> Void = { result in
            DispatchQueue.main.async {
                responseHandler(result)
            }
        }
        
        do {
            urlRequest = try requestFactory.makeRequest(data: endpoint.requestData())
        } catch {
            if let error = error as? NetworkError {
                responseHandler(.error(error))
            } else {
                responseHandler(.error(NetworkError.unknown))
            }
            
            return
        }
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                responseHandler(.error(error))
                return
            }
            
            guard let data = data else {
                responseHandler(.error(NetworkError.noOutput))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.Response.self, from: data)
                responseHandler(.success(decoded))
            } catch {
                responseHandler(.error(error))
            }
        }
        
        task.resume()
    }
}
