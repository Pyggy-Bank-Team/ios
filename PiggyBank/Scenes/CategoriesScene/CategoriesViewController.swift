import UIKit

final class CategoriesViewController: UIViewController {
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    
    private var cellWidth: CGFloat = 0
    
    var presenter: CategoriesPresenter!
    
    var sections: [CategoriesPresenter.SectionItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Categories"
        
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        navigationItem.rightBarButtonItem = rightBarItem

        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "CategoryCollectionCell")
        collectionView.register(EmptyCollectionCell.self, forCellWithReuseIdentifier: "EmptyCollectionCell")
        collectionView.register(CategoryCollectionHeader.self,
                                forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader",
                                withReuseIdentifier: "CategoryCollectionHeader")
        collectionView.backgroundColor = UIColor.piggy.white
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        presenter.getCategories()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cellWidth = view.bounds.size.width - 50
    }

}

extension CategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = presenter.getCategory(at: indexPath)
        let vc = DependencyProvider.shared.get(screen: .category(category))
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = presenter.getSection(at: indexPath.section)
        
        if section.emptyText != nil {
            return CGSize(width: cellWidth, height: 86)
        }
        
        return CGSize(width: cellWidth, height: CategoryCollectionCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let section = presenter.getSection(at: section)
        return section.emptyText != nil ? 0 : 25
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = presenter.getSection(at: section)
        
        if section.emptyText != nil {
            return 1
        }
        
        return section.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = presenter.getSection(at: indexPath.section)
        
        if section.emptyText != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCollectionCell", for: indexPath) as! EmptyCollectionCell
            cell.titleLabel.text = section.emptyText
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        let category = presenter.getCategory(at: indexPath)
        
        cell.titleLabel.text = category.title
        cell.colorView.backgroundColor = UIColor(hexString: category.hexColor)
        cell.onConfigure = { [weak self] in
            self?.showActionsList(indexPath: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionHeader" {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryCollectionHeader", for: indexPath) as! CategoryCollectionHeader
            let section = sections[indexPath.section]
            
            view.titleLabel.text = section.headerTitle
            return view
        }
        
        fatalError("Unregistered kind")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = presenter.getSection(at: section)
        return section.headerTitle != nil ? CGSize(width: cellWidth, height: 70) : .zero
    }

}

private extension CategoriesViewController {
    
    @objc
    func onAdd(_ sender: UIBarButtonItem) {
        let vc = DependencyProvider.shared.get(screen: .category(nil))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showActionsList(indexPath: IndexPath) {
        let actionsViewController = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        let category = presenter.getCategory(at: indexPath)
        
        let archiveAction = UIAlertAction(title: category.isArchived ? "Unarchive" : "Archive", style: .default) { [weak self] _ in
            self?.presenter.archive(at: indexPath)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.presenter.delete(at: indexPath)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionsViewController.addAction(archiveAction)
        actionsViewController.addAction(deleteAction)
        actionsViewController.addAction(cancelAction)
        present(actionsViewController, animated: true, completion: nil)
    }
    
}
