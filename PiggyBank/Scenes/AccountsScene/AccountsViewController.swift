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
    
    var sections: [AccountsPresenter.SectionItem] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Accounts"
        
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd(_:)))
        navigationItem.rightBarButtonItem = rightBarItem

        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AccountCollectionTotalCell.self, forCellWithReuseIdentifier: "AccountCollectionTotalCell")
        collectionView.register(AccountCollectionCell.self, forCellWithReuseIdentifier: "AccountCollectionCell")
        collectionView.register(SeparatorCollectionCell.self, forCellWithReuseIdentifier: "SeparatorCollectionCell")
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
        
        presenter.getAccounts()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        cellWidth = view.bounds.size.width - 50
    }

}

extension AccountsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let account = presenter.getAccount(at: indexPath)
        let vc = DependencyProvider.shared.get(screen: .account(account))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let section = presenter.getSection(at: indexPath.section)
        return section.totalText == nil && !section.separator && section.emptyText == nil
    }
    
}

extension AccountsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = presenter.getSection(at: indexPath.section)
        
        if section.totalText != nil {
            return CGSize(width: cellWidth, height: 113)
        }
        
        if section.separator {
            return CGSize(width: cellWidth, height: 1)
        }
        
        return CGSize(width: cellWidth, height: 86)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let section = presenter.getSection(at: section)
        
        if section.totalText == nil && !section.separator {
            return 15
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = presenter.getSection(at: section)
        
        if section.separator {
            return UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        }
        
        return .zero
    }
    
}

extension AccountsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = presenter.getSection(at: section)
        
        if section.totalText != nil || section.separator || section.emptyText != nil {
            return 1
        }
        
        return section.accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = presenter.getSection(at: indexPath.section)
        
        if section.totalText != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionTotalCell", for: indexPath) as! AccountCollectionTotalCell
            cell.subtitleLabel.text = section.totalText
            return cell
        }
        
        if section.separator {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "SeparatorCollectionCell", for: indexPath)
        }
        
        if section.emptyText != nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCollectionCell", for: indexPath) as! EmptyCollectionCell
            cell.titleLabel.text = section.emptyText
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCollectionCell", for: indexPath) as! AccountCollectionCell
        let account = presenter.getAccount(at: indexPath)
        cell.titleLabel.text = account.title
        cell.subtitleLabel.text = account.balance.description + (account.currency?.getCurrencySymbol() ?? "")
        cell.onConfigure = { [weak self] in
            self?.showActionsList(indexPath: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "UICollectionElementKindSectionHeader" {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryCollectionHeader", for: indexPath) as! CategoryCollectionHeader
            let section = presenter.getSection(at: indexPath.section)
            
            view.titleLabel.text = section.headerTitle
            return view
        }
        
        fatalError("Unregistered kind")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = presenter.getSection(at: section)
        
        if section.headerTitle != nil {
            return CGSize(width: cellWidth, height: 70)
        }
        
        return .zero
    }

}

private extension AccountsViewController {
    
    @objc
    func onAdd(_ sender: UIBarButtonItem) {
        let vc = DependencyProvider.shared.get(screen: .account(nil))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showActionsList(indexPath: IndexPath) {
        let actionsViewController = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        let account = presenter.getAccount(at: indexPath)
        
        let archiveAction = UIAlertAction(title: account.isArchived ? "Unarchive" : "Archive", style: .default) { [weak self] _ in
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
