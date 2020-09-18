import UIKit

final class CategoryCollectionCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 20
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
