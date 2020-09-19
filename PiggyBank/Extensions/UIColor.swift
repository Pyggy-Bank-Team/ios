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
