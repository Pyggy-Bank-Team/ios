import UIKit

final class AccountCollectionCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    private let configureButton = UIButton(type: .system)
    
    var onConfigure: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.piggy.gray.cgColor
        
        contentView.backgroundColor = UIColor.piggy.white
        clipsToBounds = true
        
        titleLabel.numberOfLines = 1
        titleLabel.textColor = UIColor.piggy.black
        titleLabel.font = UIFont.piggy.font14
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textColor = UIColor.piggy.black
        subtitleLabel.font = UIFont.piggy.font25
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subtitleLabel)
        
        configureButton.setImage(UIImage.piggy.icoConfigure24, for: .normal)
        configureButton.tintColor = UIColor.piggy.black
        configureButton.addTarget(self, action: #selector(onConfigure(_:)), for: .touchUpInside)
        configureButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(configureButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: configureButton.safeAreaLayoutGuide.leadingAnchor, constant: -5),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.trailingAnchor),
            
            configureButton.topAnchor.constraint(equalTo: titleLabel.safeAreaLayoutGuide.topAnchor, constant: -8),
            configureButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            configureButton.widthAnchor.constraint(equalToConstant: 40),
            configureButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension AccountCollectionCell {
    
    @objc
    func onConfigure(_ sender: UIButton) {
        onConfigure?()
    }
}
