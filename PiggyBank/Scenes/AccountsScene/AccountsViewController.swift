import UIKit

final class AccountsViewController: UIViewController {
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    
    private var cellWidth: CGFloat = 0
    
    var presenter: AccountsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Accounts"
        
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        rightBarItem.tintColor = UIColor.piggy.black
        navigationItem.rightBarButtonItem = rightBarItem
        navigationItem.hidesBackButton = true

        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AccountCollectionCell.self, forCellWithReuseIdentifier: "AccountCollectionCell")
        collectionView.register(SeparatorCollectionCell.self, forCellWithReuseIdentifier: "SeparatorCollectionCell")
        collectionView.backgroundColor = UIColor.piggy.white
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        presenter.onViewDidLoad(request: .init())
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cellWidth = view.bounds.size.width - 50
    }
    
    func viewDidLoad(response: [AccountViewModel]) {
//        allAccounts = response
//
//        for account in allAccounts {
//            if account.type == .cash {
//                cashAccounts.append(account)
//            } else {
//                cardAccounts.append(account)
//            }
//        }
        
        collectionView.reloadData()
    }
    
    func onAdd(response: AccountsDTOs.OnAdd.Response) {
        let alertController = UIAlertController(title: response.title, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func onAdd(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func onSelect(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

}

private extension AccountsViewController {
    
    @objc
    func onAdd(_ sender: UIBarButtonItem) {
        presenter.onAdd()
    }
}

extension AccountsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: cellWidth, height: 113)
        } else if indexPath.section == 1 {
            return CGSize(width: cellWidth, height: 1)
        } else {
            return CGSize(width: cellWidth, height: 86)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 {
            return UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        }
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 2 {
            return 15
        }
        
        return 0
    }
}

extension AccountsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 2 ? 9 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionCell", for: indexPath) as! AccountCollectionCell
            cell.contentViewColor = UIColor.piggy.pink
            cell.borderColor = UIColor.piggy.pink
            return cell
        } else if indexPath.section == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "SeparatorCollectionCell", for: indexPath)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionCell", for: indexPath) as! AccountCollectionCell
            cell.contentViewColor = UIColor.piggy.white
            cell.borderColor = UIColor.piggy.gray
            return cell
        }
    }
}
