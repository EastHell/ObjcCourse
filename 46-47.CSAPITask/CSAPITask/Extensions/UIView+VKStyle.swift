//
//  UIView+VKStyle.swift
//  CSAPITask
//
//  Created by Aleksandr on 20/11/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import UIKit

extension UIView {
    func configureVKStyle() {
        backgroundColor = .white
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        edgesToSuperview(insets: UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8))
    }
}
