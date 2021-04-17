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
        button.backgroundColor = UIColor(hexString: "#00B294")
        button.frame = CGRect(x: (frame.width / 2) - (realButtonWidth / 2),
                              y: -(realButtonWidth / 2),
                              width: realButtonWidth,
                              height: realButtonWidth)
        button.layer.cornerRadius = button.frame.width / 2
        addSubview(button)
        
        // Buttons
        
        let leftStackView = UIStackView()
        leftStackView.axis = .horizontal
        leftStackView.distribution = .fillEqually
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftStackView)
        
        let rightStackView = UIStackView()
        rightStackView.axis = .horizontal
        rightStackView.distribution = .fillEqually
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightStackView)
        
        leftStackView.addArrangedSubview(MenuButton(image: #imageLiteral(resourceName: "ico_bar_accounts_24"), title: "Accounts"))
        leftStackView.addArrangedSubview(MenuButton(image: #imageLiteral(resourceName: "ico_bar_reports_24"), title: "Reports"))
        
        rightStackView.addArrangedSubview(MenuButton(image: #imageLiteral(resourceName: "ico_bar_operations_24"), title: "Operations"))
        rightStackView.addArrangedSubview(MenuButton(image: #imageLiteral(resourceName: "ico_bar_profile_24"), title: "Profile"))
        
        NSLayoutConstraint.activate([
            leftStackView.topAnchor.constraint(equalTo: topAnchor),
            leftStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftStackView.leftAnchor.constraint(equalTo: leftAnchor),
            leftStackView.widthAnchor.constraint(equalToConstant: halfBeforeFirstArc),
            
            rightStackView.topAnchor.constraint(equalTo: topAnchor),
            rightStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightStackView.rightAnchor.constraint(equalTo: rightAnchor),
            rightStackView.widthAnchor.constraint(equalToConstant: halfBeforeFirstArc)
        ])
    }
}
