import UIKit

extension UIImage {

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
