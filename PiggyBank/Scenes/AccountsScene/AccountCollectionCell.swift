//
//  AccountCollectionCell.swift
//  PiggyBank
//
//  Created by Dave Chupreev on 7/3/21.
//  Copyright © 2021 Dave Chupreev. All rights reserved.
//

import UIKit

final class AccountCollectionCell: UICollectionViewCell {
    
    var borderColor = UIColor.piggy.gray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    var contentViewColor = UIColor.piggy.white {
        didSet {
            contentView.backgroundColor = contentViewColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 20
        layer.borderWidth = 1
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
