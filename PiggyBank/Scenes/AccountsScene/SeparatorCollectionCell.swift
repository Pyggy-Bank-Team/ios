//
//  SeparatorCollectionCell.swift
//  PiggyBank
//
//  Created by Dave Chupreev on 7/3/21.
//  Copyright © 2021 Dave Chupreev. All rights reserved.
//

import UIKit

final class SeparatorCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.piggy.gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
