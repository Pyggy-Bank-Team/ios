import UIKit

final class ColorCollectionCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
    }
    
}
