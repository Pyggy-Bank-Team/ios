import UIKit

final class OperationsViewController: UIViewController {
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    
    private var cellWidth: CGFloat = 0
    
    var presenter: OperationsPresenter!
    
    var sections: [OperationsPresenter.SectionItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Operations"
        
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        navigationItem.rightBarButtonItem = rightBarItem

        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OperationCollectionCell.self, forCellWithReuseIdentifier: "OperationCollectionCell")
        collectionView.register(EmptyCollectionCell.self, forCellWithReuseIdentifier: "EmptyCollectionCell")
        collectionView.register(CategoryCollectionHeader.self,
                                forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader",
                                withReuseIdentifier: "CategoryCollectionHeader")
        collectionView.backgroundColor = UIColor.piggy.white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        presenter.getOperations()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cellWidth = view.bounds.size.width - 50
    }

}

extension OperationsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let category = presenter.getCategory(at: indexPath)
//        let vc = DependencyProvider.shared.get(screen: .category(category))
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let section = presenter.getSection(at: indexPath.section)
        return section.emptyText == nil
    }
    
}

extension OperationsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = presenter.getSection(at: indexPath.section)
        
        if section.emptyText != nil {
            return CGSize(width: cellWidth, height: 86)
        }
        
        return CGSize(width: cellWidth, height: OperationCollectionCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let section = presenter.getSection(at: section)
        return section.emptyText != nil ? 0 : 25
    }
    
}

extension OperationsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = presenter.getSection(at: section)
        
        if section.emptyText != nil {
            return 1
        }
        
        return section.operations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = presenter.getSection(at: indexPath.section)
        
        if section.emptyText != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCollectionCell", for: indexPath) as! EmptyCollectionCell
            cell.titleLabel.text = section.emptyText
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OperationCollectionCell", for: indexPath) as! OperationCollectionCell
        let operation = presenter.getOperation(at: indexPath)
        let formattedAmount = operation.amount.formatSign
        let currencyCode = operation.fromAccount.currency?.getCurrencySymbol() ?? ""
        
        var imageViewBackgroundColor = UIColor.clear
        var imageViewBorderColor = UIColor.clear.cgColor
        var imageViewTintColor = UIColor.clear
        var image: UIImage?
        var titleText: String?
        var subtitleTextColor = UIColor.piggy.black
        
        if let category = operation.category {
            imageViewBackgroundColor = UIColor(hexString: category.hexColor)
            imageViewBorderColor = UIColor(hexString: category.hexColor).cgColor

            if operation.amount > 0 {
                titleText = "\(category.title) > \(operation.fromAccount.title)"
                subtitleTextColor = UIColor.piggy.green
            } else {
                titleText = "\(operation.fromAccount.title) > \(category.title)"
                subtitleTextColor = UIColor.piggy.black
            }
        }
        
        if let toAccount = operation.toAccount {
            imageViewBackgroundColor = UIColor.piggy.white
            imageViewBorderColor = UIColor.piggy.gray.cgColor
            imageViewTintColor = UIColor.piggy.gray
            image = #imageLiteral(resourceName: "ico_bar_operations_24")

            titleText = "\(operation.fromAccount.title) > \(toAccount.title)"
            subtitleTextColor = UIColor.piggy.green
        }
        
        cell.imageView.backgroundColor = imageViewBackgroundColor
        cell.imageView.layer.borderColor = imageViewBorderColor
        cell.imageView.image = image
        cell.imageView.tintColor = imageViewTintColor
        cell.titleLabel.text = titleText
        cell.subtitleLabel.text = "\(formattedAmount)\(currencyCode)"
        cell.subtitleLabel.textColor = subtitleTextColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionHeader" {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryCollectionHeader", for: indexPath) as! CategoryCollectionHeader
            let section = sections[indexPath.section]
            
            view.titleLabel.text = section.headerTitle
            view.subtitleLabel.text = section.headerSubitle
            return view
        }
        
        fatalError("Unregistered kind")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = presenter.getSection(at: section)
        return section.headerTitle != nil ? CGSize(width: cellWidth, height: 70) : .zero
    }

}

private extension OperationsViewController {
    
    @objc
    func onAdd(_ sender: UIBarButtonItem) {
        let vc = DependencyProvider.shared.get(screen: .operation(nil))
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
