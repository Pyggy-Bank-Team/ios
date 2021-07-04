import UIKit

final class OperationCollectionCell: UICollectionViewCell {
    
    static let height: CGFloat = 40
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.piggy.gray.cgColor
        imageView.layer.cornerRadius = OperationCollectionCell.height / 2
        imageView.contentMode = .center
        contentView.addSubview(imageView)
        
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.piggy.font14
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.textColor = UIColor.piggy.black
        contentView.addSubview(titleLabel)
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = UIFont.piggy.fontSemibold14
        subtitleLabel.textAlignment = .right
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: OperationCollectionCell.height),
            imageView.widthAnchor.constraint(equalToConstant: OperationCollectionCell.height),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            subtitleLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.backgroundColor = .clear
        imageView.layer.borderColor = UIColor.clear.cgColor
        imageView.image = nil
        imageView.tintColor = .clear
        
        titleLabel.text = nil
        
        subtitleLabel.text = nil
        subtitleLabel.textColor = UIColor.piggy.black
    }

}
