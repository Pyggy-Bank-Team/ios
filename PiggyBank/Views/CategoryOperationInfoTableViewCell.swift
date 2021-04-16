//
//  CategoryOperationInfoTableViewCell.swift
//  PiggyBank
//

import UIKit

class CategoryOperationInfoTableViewCell: UITableViewCell {

    static let identifier = "CategoryOperationInfoTableViewCell"

    private let circleView: UIView = {
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.cornerRadius = 20
        circleView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 40.0),
            circleView.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        return circleView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        return titleLabel
    }()

    private let amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        return amountLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func configureView() {
        contentView.addSubview(circleView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(amountLabel)

        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 8.0),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: amountLabel.leadingAnchor),

            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func build(color: UIColor, name: String, amount: String) {
        circleView.backgroundColor = color
        titleLabel.text = name
        amountLabel.text = amount
    }
}
