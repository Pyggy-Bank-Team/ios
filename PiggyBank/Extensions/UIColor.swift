import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        guard hexString.starts(with: "#"), hexString.count == 9 else {
            fatalError("Color can't be decoded")
        }
        
        let startIndex = hexString.startIndex
        let redIndex = hexString.index(startIndex, offsetBy: 1)
        let greenIndex = hexString.index(startIndex, offsetBy: 3)
        let blueIndex = hexString.index(startIndex, offsetBy: 5)
        let alphaIndex = hexString.index(startIndex, offsetBy: 7)
        let endIndex = hexString.endIndex
        
        let rValue = Int(hexString[redIndex..<greenIndex], radix: 16)!
        let gValue = Int(hexString[greenIndex..<blueIndex], radix: 16)!
        let bValue = Int(hexString[blueIndex..<alphaIndex], radix: 16)!
        let aValue = Int(hexString[alphaIndex..<endIndex], radix: 16)!
        
        self.init(
            red: CGFloat(rValue) / 255.0,
            green: CGFloat(gValue) / 255.0,
            blue: CGFloat(bValue) / 255.0,
            alpha: CGFloat(aValue) / 255.0
        )
    }
    
}
