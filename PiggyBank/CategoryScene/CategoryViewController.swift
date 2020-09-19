import UIKit

final class CategoryViewController: UIViewController {
    
    var presenter: CategoryPresenter!
    
    override func loadView() {
        view = CategoryView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSave(_:)))
        
        view.backgroundColor = .white
        
        (view as! CategoryView).onDelete = { [weak self] in
            self?.presenter.onDelete()
        }
        
        presenter.loadData()
    }
    
    func loadCategory(category: CategoryViewModel?) {
        if category == nil {
            navigationItem.title = "New"
        }
        
        (view as! CategoryView).loadCategory(category: category)
    }
    
    func notifyFromAPI() {
        let alertController = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }

}

extension CategoryViewController {
    
    var categoryType: Int {
        return (view as! CategoryView).typeControl.selectedSegmentIndex
    }
    
    var categoryTitle: String {
        return (view as! CategoryView).titleField.text ?? ""
    }
    
    var categoryArchived: Bool {
        return (view as! CategoryView).archiveSwitch.isOn
    }
    
    var categoryHex: String {
        let indexPath = (view as! CategoryView).collectionView.indexPathsForSelectedItems?.first ?? IndexPath(row: 0, section: 0)
        return COLORS[indexPath.row]
    }
    
}

private extension CategoryViewController {
    
    @objc func onSave(_ sender: UIBarButtonItem) {
        presenter.onSave()
    }
    
}
