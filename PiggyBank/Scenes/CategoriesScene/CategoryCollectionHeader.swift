//
//  CategoryCollectionHeader.swift
//  PiggyBank
//
//  Created by Dave Chupreev on 7/3/21.
//  Copyright © 2021 Dave Chupreev. All rights reserved.
//

import UIKit

final class CategoryCollectionHeader: UICollectionReusableView {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.piggy.white
        
        titleLabel.font = UIFont.piggy.fontSemibold14
        titleLabel.textColor = UIColor.piggy.gray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
