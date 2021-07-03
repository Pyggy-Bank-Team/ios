import UIKit

public final class CategoryCollectionCell: UICollectionViewCell {
    
    static let height: CGFloat = 40
    
    let colorView = UIView()
    let titleLabel = UILabel()
    
    private let configureButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.layer.cornerRadius = CategoryCollectionCell.height / 2
        contentView.addSubview(colorView)
        
        titleLabel.font = UIFont.piggy.font14
        titleLabel.textColor = UIColor.piggy.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        contentView.addSubview(titleLabel)
        
        configureButton.setImage(UIImage.piggy.icoConfigure24, for: .normal)
        configureButton.tintColor = UIColor.piggy.black
        configureButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(configureButton)
        
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: CategoryCollectionCell.height),
            colorView.heightAnchor.constraint(equalToConstant: CategoryCollectionCell.height),
            colorView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            colorView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: colorView.safeAreaLayoutGuide.rightAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: configureButton.safeAreaLayoutGuide.leftAnchor, constant: -8),
            
            configureButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            configureButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            configureButton.widthAnchor.constraint(equalToConstant: CategoryCollectionCell.height),
            configureButton.heightAnchor.constraint(equalToConstant: CategoryCollectionCell.height)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
