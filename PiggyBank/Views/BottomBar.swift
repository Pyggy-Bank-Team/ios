import UIKit

final class BottomBar: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        let buttonWidth: CGFloat = 66
        let buttonRadius: CGFloat = buttonWidth / 2
        
        let halfBeforeFirstArc = (rect.width - buttonWidth) / 2
        let rectHalf: CGFloat = 0
        
        UIColor.white.setFill()
        path.move(to: .init(x: 0, y: rect.height))
        path.addLine(to: .init(x: 0, y: rectHalf))
        path.addLine(to: .init(x: halfBeforeFirstArc, y: rectHalf))
        
        path.addArc(withCenter: .init(x: (halfBeforeFirstArc) + buttonRadius, y: rectHalf),
                    radius: buttonRadius,
                    startAngle: .pi,
                    endAngle: 2 * .pi,
                    clockwise: false)

        path.addLine(to: .init(x: rect.width, y: rectHalf))
        path.addLine(to: .init(x: rect.width, y: rect.height))
        path.addLine(to: .init(x: 0, y: rect.height))
        path.fill()
        
        let realButtonWidth: CGFloat = 56
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemGreen
        button.frame = CGRect(x: (frame.width / 2) - (realButtonWidth / 2),
                              y: -(realButtonWidth / 2),
                              width: realButtonWidth,
                              height: realButtonWidth)
        button.layer.cornerRadius = button.frame.width / 2
        addSubview(button)
    }
    
    override func layoutSubviews() {
//        let view = UIView(frame: .init(x: 10, y: 0, width: 20, height: bounds.height))
//        view.backgroundColor = .red
//        addSubview(view)
        
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ico_bar_accounts_24"), for: .normal)
        button.setTitle("Accounts", for: .normal)
        button.tintColor = .black
        button.frame = CGRect(origin: .zero, size: CGSize(width: 24, height: 24))
        addSubview(button)
    }
}
