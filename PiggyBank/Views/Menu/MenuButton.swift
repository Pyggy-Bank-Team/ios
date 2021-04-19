//
//  MenuButton.swift
//  PiggyBank
//

import UIKit

final class MenuButton: UIView {
    
    init(image: UIImage, title: String) {
        super.init(frame: .zero)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.frame = CGRect(origin: .zero, size: CGSize(width: 24, height: 24))
        stackView.addArrangedSubview(button)
        
        let label = UILabel()
        label.text = title
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .center
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
