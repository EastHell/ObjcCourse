//
//  WallPostTableViewCell.swift
//  CSAPIBasicTask
//
//  Created by Aleksandr on 21/08/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import UIKit

class WallPostTableViewCell: UITableViewCell {
    
    @objc
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    @objc
    var totalHeight: CGFloat {
        var height: CGFloat = 0
        
        for arranged in stackView.arrangedSubviews {
            arranged.sizeToFit()
            height += arranged.frame.height
        }
        
        return height
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        //Adding subviews
        contentView.addSubview(stackView)
        stackView.edgesToSuperview()
    }
    
    override func prepareForReuse() {
        for arranged in stackView.arrangedSubviews {
            arranged.removeFromSuperview()
        }
    }
}
