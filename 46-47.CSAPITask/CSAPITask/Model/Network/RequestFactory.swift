//
//  RequestFactory.swift
//  CSAPITask
//
//  Created by Aleksandr on 26/10/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

protocol IRequestFactory {
    func makeRequest(data: RequestData) throws -> URLRequest
}

struct RequestFactory {
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}

enum Version: Double {
    case actual = 5.124
}

extension RequestFactory: IRequestFactory {
    func makeRequest(data: RequestData) throws -> URLRequest {
        var urlRequest = try URLRequest(url: buildUrl(with: data))
        urlRequest.httpMethod = data.method.rawValue
        urlRequest.timeoutInterval = 30
        
        for header in data.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        for header in HTTPHeader.default {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        switch data.body {
        case .empty:
            break
        case let .data(data):
            urlRequest.httpBody = data
        case let .dict(json):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        }
        
        return urlRequest
    }
    
    private func buildUrl(with request: RequestData) throws -> URL {
        var urlString = request.path
        var parameters = request.parameters
        
        if let accessToken = AccessToken.currentToken() {
            let comparator = accessToken.expiresDate.compare(Date())
            if comparator == .orderedAscending || comparator == .orderedSame {
                throw NetworkError.expiredAccessToken
            }
            parameters["access_token"] = accessToken.token
        } else {
            throw NetworkError.noAccessToken
        }
        
        if parameters["v"] == nil {
            parameters["v"] = Version.actual.rawValue
        }
        
        if !parameters.isEmpty {
            let urlParameters = parameters.compactMap { item -> String? in
                guard
                    let key = item.key
                        .addingPercentEncoding(withAllowedCharacters: .alphanumerics),
                    let value = String(describing: item.value)
                        .addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                    else {
                        return nil
                }
                return key + "=" + value
            }
            urlString += "?" + urlParameters.joined(separator: "&")
        }
        
        guard let url = URL(string: urlString, relativeTo: baseURL) else {
            throw NetworkError.incorrectURL
        }
        
        return url
    }
}
