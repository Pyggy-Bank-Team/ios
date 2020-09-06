import UIKit

final class CreateCategoryViewController: UIViewController {
    
    private lazy var titleField = UITextField()
    private lazy var typeControl = UISegmentedControl()
    
    var completion: ((String, Int) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        navigationItem.title = "New Category"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone(_:)))
        
        titleField.placeholder = "Title"
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.textAlignment = .center
        
        typeControl.insertSegment(withTitle: "Income", at: 0, animated: true)
        typeControl.insertSegment(withTitle: "Outcome", at: 1, animated: true)
        typeControl.selectedSegmentIndex = 0
        typeControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleField)
        view.addSubview(typeControl)
        
        NSLayoutConstraint.activate([
            typeControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            typeControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            typeControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleField.topAnchor.constraint(equalTo: typeControl.bottomAnchor, constant: 50),
            titleField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            titleField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

private extension CreateCategoryViewController {
    
    @objc func onDone(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        completion?(titleField.text ?? "", typeControl.selectedSegmentIndex)
    }
    
}
