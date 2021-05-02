//
//  Apperance.swift
//  PiggyBank
//

import UIKit

enum Apperance {

    static func setup() {
        PrimaryButton.appearance()
        PrimaryButton.appearance().setTitleColor(.black, for: .normal)
        PrimaryButton.appearance().backgroundColor = UIColor(hexString: "#1CC8EE")

        SecondaryButton.appearance().setTitleColor(UIColor(hexString: "#4E4B66"), for: .normal)
    }
}
