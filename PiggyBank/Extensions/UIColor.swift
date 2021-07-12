import UIKit

extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1) {
        guard hexString.starts(with: "#"), hexString.count == 7 else {
            fatalError("Color can't be decoded")
        }
        
        let startIndex = hexString.startIndex
        let redIndex = hexString.index(startIndex, offsetBy: 1)
        let greenIndex = hexString.index(startIndex, offsetBy: 3)
        let blueIndex = hexString.index(startIndex, offsetBy: 5)
        let endIndex = hexString.endIndex
        
        let rValue = Int(hexString[redIndex..<greenIndex], radix: 16)!
        let gValue = Int(hexString[greenIndex..<blueIndex], radix: 16)!
        let bValue = Int(hexString[blueIndex..<endIndex], radix: 16)!
        
        self.init(
            red: CGFloat(rValue) / 255.0,
            green: CGFloat(gValue) / 255.0,
            blue: CGFloat(bValue) / 255.0,
            alpha: alpha
        )
    }
}

// MARK: - Used for DatePickerDialog

extension UIColor {
    
    // swiftlint:disable type_name
    enum piggy {
        
        static let pink = UIColor(hexString: "#cf5ea4")
        static let black = UIColor(hexString: "#14142B")
        static let white = UIColor(hexString: "#ffffff")
        static let gray = UIColor(hexString: "#a0a3bd")
        static let green = UIColor(hexString: "#219653")
        static let red = UIColor(hexString: "#DA3B01")
    }

    static var gradientBackground: [CGColor] {
        if #available(iOS 13.0, *) {
            return [
                UIColor.systemGray4.cgColor,
                UIColor.systemGray5.cgColor,
                UIColor.systemGray5.cgColor
            ]
        } else {
            return [
                UIColor(hexString: "0xDADADE").cgColor,
                UIColor(hexString: "0xEAEAEE").cgColor,
                UIColor(hexString: "0xDADADE").cgColor
            ]
        }
    }

    static var separator: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray3
        } else {
            return UIColor(hexString: "0xD1D1D6")
        }
    }

    static var text: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor(hexString: "0x3993F8")
        }
    }

    static var accent: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBlue
        } else {
            return UIColor(hexString: "0x3993F8")
        }
    }
}
