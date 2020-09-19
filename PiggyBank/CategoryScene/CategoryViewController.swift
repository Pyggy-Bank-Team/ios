import UIKit

final class CategoryViewController: UIViewController {
    
    private var categoryViewModel: CategoryViewModel?
    
    private lazy var typeControl = UISegmentedControl()
    private lazy var titleField = UITextField()
    private lazy var titleBorderView = UIView()
    private lazy var archivedLabel = UILabel()
    private lazy var archiveSwitch = UISwitch()
    private lazy var colorView = UIView()
    private var collectionView: UICollectionView!
    private lazy var deleteButton = UIButton(type: .system)
    private lazy var deleteBorderView = UIView()
    
    var presenter: CategoryPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onSave(_:)))

        view.backgroundColor = .white
        
        typeControl.insertSegment(withTitle: "Income", at: 0, animated: false)
        typeControl.insertSegment(withTitle: "Outcome", at: 1, animated: false)
        typeControl.translatesAutoresizingMaskIntoConstraints = false
        
        titleField.placeholder = "Title"
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.autocorrectionType = .no
        
        titleBorderView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1991362236)
        titleBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        archivedLabel.text = "Archived"
        archivedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        archiveSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        colorView.layer.cornerRadius = 5
        colorView.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ColorCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(onDelete(_:)), for: .touchUpInside)
        
        deleteBorderView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1991362236)
        deleteBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(typeControl)
        view.addSubview(titleField)
        view.addSubview(titleBorderView)
        view.addSubview(archivedLabel)
        view.addSubview(archiveSwitch)
        view.addSubview(colorView)
        view.addSubview(collectionView)
        view.addSubview(deleteButton)
        view.addSubview(deleteBorderView)
        
        NSLayoutConstraint.activate([
            typeControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            typeControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            typeControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            titleField.topAnchor.constraint(equalTo: typeControl.bottomAnchor, constant: 40),
            titleField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            titleField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            titleBorderView.widthAnchor.constraint(equalTo: titleField.widthAnchor),
            titleBorderView.heightAnchor.constraint(equalToConstant: 0.5),
            titleBorderView.topAnchor.constraint(equalTo: titleField.bottomAnchor),
            titleBorderView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            
            archivedLabel.widthAnchor.constraint(equalTo: titleBorderView.widthAnchor, multiplier: 0.6),
            archivedLabel.topAnchor.constraint(equalTo: titleBorderView.bottomAnchor, constant: 30),
            archivedLabel.leadingAnchor.constraint(equalTo: titleBorderView.leadingAnchor),
            
            archiveSwitch.centerYAnchor.constraint(equalTo: archivedLabel.centerYAnchor),
            archiveSwitch.trailingAnchor.constraint(equalTo: titleBorderView.trailingAnchor),
            
            colorView.widthAnchor.constraint(equalTo: titleBorderView.widthAnchor),
            colorView.heightAnchor.constraint(equalToConstant: 10),
            colorView.topAnchor.constraint(equalTo: archivedLabel.bottomAnchor, constant: 30),
            colorView.leadingAnchor.constraint(equalTo: titleBorderView.leadingAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            collectionView.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            deleteBorderView.widthAnchor.constraint(equalTo: deleteButton.widthAnchor),
            deleteBorderView.heightAnchor.constraint(equalToConstant: 0.5),
            deleteBorderView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor),
            
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        presenter.loadData()
    }
    
    func loadCategory(category: CategoryViewModel?) {
        categoryViewModel = category
        
        if let category = category {
            typeControl.selectedSegmentIndex = category.type.rawValue
            titleField.text = category.title
            archiveSwitch.isOn = category.isArchived
            colorView.backgroundColor = UIColor(hexString: category.hexColor)
        } else {
            typeControl.selectedSegmentIndex = 0
            deleteBorderView.isHidden = true
            deleteButton.isHidden = true
            titleField.becomeFirstResponder()
            archiveSwitch.isOn = false
            navigationItem.title = "New"
            colorView.backgroundColor = UIColor(hexString: COLORS.first!)
        }
    }
    
    func notifyFromAPI() {
        let alertController = UIAlertController(title: "Success", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: view)
        
        if !titleField.frame.contains(location) {
            view.endEditing(true)
        }
    }
    
    

}

extension CategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.colorView.backgroundColor = UIColor(hexString: COLORS[indexPath.row])
        }
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COLORS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let color = COLORS[indexPath.row]
        
        cell.backgroundColor = UIColor(hexString: color)
        
        return cell
    }
    
}

private extension CategoryViewController {
    
    @objc func onSave(_ sender: UIBarButtonItem) {
        presenter.onSave()
    }
    
    @objc func onDelete(_ sender: UIButton) {
        presenter.onDelete()
    }
    
}
