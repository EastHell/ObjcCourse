//
//  NetworkError.swift
//  CSAPITask
//
//  Created by Aleksandr on 26/10/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case incorrectURL
    case unknown
    case noOutput
    case noAccessToken
    case expiredAccessToken
    
    var localizedDescription: String {
        switch self {
        case .incorrectURL:
            return "Неизвестный путь"
        case .unknown:
            return "Неизвестная ошибка"
        case .noOutput:
            return "Нет данных"
        case .noAccessToken:
            return "Отсутствует токен"
        case .expiredAccessToken:
            return "Токен истек"
        }
    }
}
