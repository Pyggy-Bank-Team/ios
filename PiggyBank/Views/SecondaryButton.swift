//
//  SecondaryButton.swift
//  PiggyBank
//

import UIKit

class SecondaryButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .medium)
    }
}
