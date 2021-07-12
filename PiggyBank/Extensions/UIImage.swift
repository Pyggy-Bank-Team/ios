import UIKit

extension UIImage {
    
    // swiftlint:disable type_name
    enum piggy {
        
        static let icoConfigure24 = UIImage(named: "ico_configure_24")
    }

    static func imageFrom(color: UIColor) -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
