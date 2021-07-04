import UIKit

final class CategoryCollectionHeader: UICollectionReusableView {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.piggy.white
        
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.piggy.fontSemibold14
        titleLabel.textColor = UIColor.piggy.gray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        addSubview(titleLabel)
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = UIFont.piggy.fontSemibold14
        subtitleLabel.textAlignment = .right
        subtitleLabel.textColor = UIColor.piggy.gray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            
            subtitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            subtitleLabel.centerYAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
