//
//  DateFormatter+Short.swift
//  CSAPITask
//
//  Created by Aleksandr on 23/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let dateAndTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
}
