import UIKit

final class BottomBar: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        let buttonWidth: CGFloat = 66
        let buttonRadius: CGFloat = buttonWidth / 2
        
        let halfBeforeFirstArc = (rect.width - buttonWidth) / 2 - 5
        let rectHalf: CGFloat = 0
        
        UIColor.white.setFill()
        path.move(to: .init(x: 0, y: rect.height))
        path.addLine(to: .init(x: 0, y: rectHalf))
        path.addLine(to: .init(x: halfBeforeFirstArc, y: rectHalf))
        
        path.addArc(withCenter: .init(x: halfBeforeFirstArc, y: rectHalf + 5),
                    radius: 5,
                    startAngle: 3 * .pi / 2,
                    endAngle: 2 * .pi,
                    clockwise: true)
        
        path.addArc(withCenter: .init(x: (halfBeforeFirstArc + 5) + buttonRadius, y: rectHalf + 5),
                    radius: buttonRadius,
                    startAngle: .pi,
                    endAngle: 2 * .pi,
                    clockwise: false)
        
        path.addArc(withCenter: .init(x: (halfBeforeFirstArc + 5) + buttonWidth + 5, y: rectHalf + 5),
                    radius: 5,
                    startAngle: .pi,
                    endAngle: 3 * .pi / 2,
                    clockwise: true)

        path.addLine(to: .init(x: rect.width, y: rectHalf))
        path.addLine(to: .init(x: rect.width, y: rect.height))
        path.addLine(to: .init(x: 0, y: rect.height))
        path.fill()
        
        
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemGreen
        button.frame = CGRect(x: frame.width / 2 - 30,
                              y: 0 - buttonRadius + 5,
                              width: 60,
                              height: 60)
        button.layer.cornerRadius = button.frame.width / 2
        addSubview(button)
    }
}
