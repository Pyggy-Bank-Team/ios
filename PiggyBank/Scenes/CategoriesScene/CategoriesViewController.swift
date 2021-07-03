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
    
    private var allCategories: [CategoryViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Categories"
        
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        rightBarItem.tintColor = UIColor.piggy.black
        navigationItem.rightBarButtonItem = rightBarItem
        navigationItem.hidesBackButton = true

        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "CategoryCollectionCell")
        collectionView.backgroundColor = UIColor.piggy.white
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
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
        allCategories = categories
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: cellWidth, height: CategoryCollectionCell.height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        25
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        let category = element(at: indexPath)
        
        cell.titleLabel.text = category.title
        cell.colorView.backgroundColor = UIColor(hexString: category.hexColor)
        
        return cell
    }
    
}

private extension CategoriesViewController {
    
    @objc
    func onAdd(_ sender: UIBarButtonItem) {
        presenter.onAdd()
    }
    
    @objc
    func onChangeType(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    
    func element(at indexPath: IndexPath) -> CategoryViewModel {
        return allCategories[indexPath.row]
    }
    
}
