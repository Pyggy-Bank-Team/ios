import UIKit

extension UISegmentedControl {

    func ensureiOS12Style() {
        if #available(iOS 13, *) {
            let tintColorImage = UIImage.imageFrom(color: tintColor)
            // Must set the background image for normal to something (even clear) else the rest won't work
            setBackgroundImage(UIImage.imageFrom(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: .selected, barMetrics: .default)
            setBackgroundImage(UIImage.imageFrom(color: tintColor.withAlphaComponent(0.2)), for: .highlighted, barMetrics: .default)
            setBackgroundImage(tintColorImage, for: [.highlighted, .selected], barMetrics: .default)
            setTitleTextAttributes([.foregroundColor: tintColor ?? .clear, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)], for: .normal)
            setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            layer.borderWidth = 1
            layer.borderColor = tintColor.cgColor
        }
    }
}

/*

 Changing SegmentedCOntrol peorperties

 if #available(iOS 13.0, *) {
     operationTypeControl.backgroundColor = UIColor.black
     operationTypeControl.selectedSegmentTintColor = UIColor.white

     let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
     operationTypeControl.setTitleTextAttributes(titleTextAttributes, for:.normal)

     let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
     operationTypeControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)
 } else {

 }

 */
