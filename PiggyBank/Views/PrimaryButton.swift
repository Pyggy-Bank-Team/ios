//
//  PrimaryButton.swift
//  PiggyBank
//

import UIKit

class PrimaryButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            self.alpha = isEnabled ? 1.0 : 0.5
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 4.0
        self.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .medium)
    }
}
