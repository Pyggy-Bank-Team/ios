//
//  PrimaryButton.swift
//  PiggyBank
//

import UIKit

class PrimaryButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 4.0
        self.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .medium)
    }
}
