//
//  ContentBlockView.swift
//  PiggyBank
//

import UIKit

class ContentBlockView: UIView {

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 15.0, weight: .regular)
        titleLabel.textColor = UIColor(hexString: "#A0A3BD")
        return titleLabel
    }()

    private(set) lazy var valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = .systemFont(ofSize: 17.0, weight: .regular)
        valueLabel.textColor = UIColor(hexString: "#0D1C36")
        return valueLabel
    }()

    private lazy var infoContentView: UIStackView = {
        let infoContentView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        infoContentView.translatesAutoresizingMaskIntoConstraints = false
        infoContentView.axis = .vertical
        infoContentView.spacing = 4.0
        return infoContentView
    }()

    private lazy var chevronImageView: UIImageView = {
        let chevronImageView = UIImageView(image: #imageLiteral(resourceName: "chevron"))
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        return chevronImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(infoContentView)
        addSubview(chevronImageView)

        NSLayoutConstraint.activate([
            infoContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoContentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoContentView.topAnchor.constraint(equalTo: topAnchor),
            infoContentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func build(title: String?, value: String) {
        if let title = title {
            titleLabel.text = title
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
        valueLabel.text = value
    }
}
