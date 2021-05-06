//
//  UIView+Constraints.swift
//  CurrencyRate
//
//  Created by Юрий Логинов on 08/04/2019.
//  Copyright © 2019 Юрий Логинов. All rights reserved.
//

import UIKit

extension UIView {
    func edgesToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let left = leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left)
        let right = rightAnchor.constraint(equalTo: superview.rightAnchor, constant: insets.right)
        let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom)
        
        NSLayoutConstraint.activate([left, right, top, bottom])
    }
    
    func leftAndRightToSuperview(insets: CGFloat) {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let left = leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets)
        let right = rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets)
        
        NSLayoutConstraint.activate([left, right])
    }
    
    func bottomToSuperview(inset: CGFloat) {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: inset)
        NSLayoutConstraint.activate([bottom])
    }
    
    func centerToSuperview() {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let cx = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let cy = centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        
        NSLayoutConstraint.activate([cx, cy])
    }
    
    func height(equalTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func width(equalTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
