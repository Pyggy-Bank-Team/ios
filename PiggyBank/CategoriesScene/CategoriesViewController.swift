import UIKit

class CategoriesViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    var presenter: CategoriesPresenter!
    private var categories: [CategoryViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
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
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        navigationItem.title = "Categories"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        
        presenter.onViewDidLoad()
    }
    
    func viewDidLoad(categories: [CategoryViewModel]) {
        self.categories = categories
        collectionView.reloadData()
    }
    
    func showResult(str: String) {
        let alertController = UIAlertController(title: str, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }

}

//extension CategoriesViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let category = categories[indexPath.row]
//        var actions: [UIContextualAction] = []
//
//        let deleteAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
//            self?.presenter.onDeleteCategory(request: .init(index: indexPath.row))
//            complete(true)
//        }
//        deleteAction.image = #imageLiteral(resourceName: "delete")
//        actions.append(deleteAction)
//
//        if !category.isArchived {
//            let archiveAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
//                self?.presenter.onArchiveCategory(request: .init(index: indexPath.row))
//                complete(true)
//            }
//            archiveAction.image = #imageLiteral(resourceName: "archive")
//            actions.append(archiveAction)
//        }
//
//        let renameAction = UIContextualAction(style: .normal, title: "") { [weak self] _, _, complete in
//            guard let self = self else { return }
//
//            let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
//
//            alertController.addTextField { textField in
//                textField.placeholder = "Enter new title"
//                textField.text = category.title
//            }
//
//            alertController.addTextField { textField in
//                textField.placeholder = "Enter new color"
//                textField.text = category.hexColor
//            }
//
//            let okAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
//                self.presenter.onChangeCategory(request: .init(
//                    index: indexPath.row,
//                    title: alertController?.textFields?.first?.text ?? "",
//                    color: alertController?.textFields?.last?.text ?? "")
//                )
//            }
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
//
//            alertController.addAction(okAction)
//            alertController.addAction(cancelAction)
//            self.present(alertController, animated: true, completion: nil)
//
//            complete(true)
//        }
//        renameAction.image = #imageLiteral(resourceName: "rename")
//        actions.append(renameAction)
//
//        actions.forEach {
//            $0.backgroundColor = .white
//        }
//
//        let swipeConfiguration = UISwipeActionsConfiguration(actions: actions)
//        swipeConfiguration.performsFirstActionWithFullSwipe = false
//
//        return swipeConfiguration
//    }
//
//}

//extension CategoriesViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell
//
//        if let res = tableView.dequeueReusableCell(withIdentifier: "Cell") {
//            cell = res
//        } else {
//            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
//        }
//
//        let category = categories[indexPath.row]
//
//        cell.textLabel?.text = category.title
//        cell.detailTextLabel?.text = category.type == .income ? "Income" : "Outcome"
//
//        if category.isArchived {
//            cell.imageView?.image = #imageLiteral(resourceName: "archive")
//        }
//
//        return cell
//    }
//
//}

extension CategoriesViewController: UICollectionViewDelegate {
    
    
    
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.8, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionCell
        let category = categories[indexPath.row]
        
        cell.titleLabel.text = category.title
        cell.backgroundColor = UIColor(hexString: "#ff10893e")
        
        return cell
    }
    
}

private extension CategoriesViewController {
    
    @objc func onAdd(_ sender: UIBarButtonItem) {
//        let createCategoryVC = CreateCategoryViewController()
//
//        createCategoryVC.completion = { title, type in
//            self.presenter.onCreateCategory(request: .init(title: title, type: type, color: "#ffffff"))
//        }
//
//        navigationController?.pushViewController(createCategoryVC, animated: true)
    }
    
}
