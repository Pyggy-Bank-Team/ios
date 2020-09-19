import UIKit

class CategoriesViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private lazy var typeControl = UISegmentedControl()
    
    var presenter: CategoriesPresenter!
    
    private var allCategories: [CategoryViewModel] = []
    private var incomeCategories: [CategoryViewModel] = []
    private var outcomeCategories: [CategoryViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        typeControl.translatesAutoresizingMaskIntoConstraints = false
        typeControl.addTarget(self, action: #selector(onChangeType(_:)), for: .valueChanged)
        view.addSubview(typeControl)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            typeControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            typeControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            typeControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: typeControl.bottomAnchor)
        ])
        
        navigationItem.title = "Categories"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        
        presenter.onViewDidLoad()
    }
    
    func viewDidLoad(categories: [CategoryViewModel]) {
        allCategories = categories
        
        for category in categories {
            if category.type == .income {
                incomeCategories.append(category)
            } else {
                outcomeCategories.append(category)
            }
        }
        
        typeControl.insertSegment(withTitle: "All", at: 0, animated: false)
        
        var indexToInsert = 1
        if !incomeCategories.isEmpty {
            typeControl.insertSegment(withTitle: "Income", at: indexToInsert, animated: false)
            indexToInsert += 1
        }
        
        if !outcomeCategories.isEmpty {
            typeControl.insertSegment(withTitle: "Outcome", at: indexToInsert, animated: false)
        }
        
        typeControl.selectedSegmentIndex = 0
        
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
        return CGSize(width: collectionView.bounds.width * 0.8, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard typeControl.selectedSegmentIndex >= 0 else { return 0 }
        
        let selected = typeControl.selectedSegmentIndex
        
        if selected == 0 {
            return allCategories.count
        } else if selected == 1 && !incomeCategories.isEmpty {
            return incomeCategories.count
        } else {
            return outcomeCategories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionCell
        let category = element(at: indexPath)
        
        var text = category.title
        
        if category.isArchived {
            text += " • Archived"
        }
        
        cell.titleLabel.text = text
        cell.backgroundColor = UIColor(hexString: category.hexColor, alpha: 0.3)
        
        return cell
    }
    
}

private extension CategoriesViewController {
    
    @objc func onAdd(_ sender: UIBarButtonItem) {
        presenter.onAdd()
    }
    
    @objc func onChangeType(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    
    func element(at indexPath: IndexPath) -> CategoryViewModel {
        let selected = typeControl.selectedSegmentIndex
        
        if selected == 0 {
            return allCategories[indexPath.row]
        } else if selected == 1 && !incomeCategories.isEmpty {
            return incomeCategories[indexPath.row]
        } else {
            return outcomeCategories[indexPath.row]
        }
    }
    
}
