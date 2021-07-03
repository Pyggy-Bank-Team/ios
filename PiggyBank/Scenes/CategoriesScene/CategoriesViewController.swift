import UIKit

final class CategoriesViewController: UIViewController {
    
    private class SectionItem {
        
        let headerTitle: String?
        var categories: [CategoryViewModel] = []
        
        init(title: String?) {
            self.headerTitle = title
        }
    }
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    
    private var cellWidth: CGFloat = 0
    
    var presenter: CategoriesPresenter!
    
    private var sections: [SectionItem] = []

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
        
        presenter.onViewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cellWidth = view.bounds.size.width - 50
    }
    
    func viewDidLoad(categories: [CategoryViewModel]) {
        let incomeCategories = SectionItem(title: "Income")
        let outcomeCategories = SectionItem(title: "Outcome")
        let archivedIncomeCategories = SectionItem(title: "Archive • Income")
        let archivedOutcomeCategories = SectionItem(title: "Archive • Outcome")
        
        categories.forEach { category in
            if category.type == .income {
                if category.isArchived {
                    archivedIncomeCategories.categories.append(category)
                } else {
                    incomeCategories.categories.append(category)
                }
            } else {
                if category.isArchived {
                    archivedOutcomeCategories.categories.append(category)
                } else {
                    outcomeCategories.categories.append(category)
                }
            }
        }
        
        sections = [incomeCategories, outcomeCategories, archivedIncomeCategories, archivedOutcomeCategories]
        collectionView.reloadData()
    }
    
    func showResult(str: String) {
        let alertController = UIAlertController(title: str, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension CategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = element(at: indexPath)
        presenter.onSelect(id: category.id)
    }
    
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: cellWidth, height: CategoryCollectionCell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        25
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.filter { !$0.categories.isEmpty }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        let category = element(at: indexPath)
        
        cell.titleLabel.text = category.title
        cell.colorView.backgroundColor = UIColor(hexString: category.hexColor)
        
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
        CGSize(width: cellWidth, height: 70)
    }
}

private extension CategoriesViewController {
    
    @objc
    func onAdd(_ sender: UIBarButtonItem) {
        presenter.onAdd()
    }
    
    func element(at indexPath: IndexPath) -> CategoryViewModel {
        sections[indexPath.section].categories[indexPath.row]
    }
    
}
