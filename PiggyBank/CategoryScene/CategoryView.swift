import UIKit

final class CategoryView: UIView {
    
    lazy var typeControl = UISegmentedControl()
    lazy var titleField = UITextField()
    lazy var titleBorderView = UIView()
    lazy var archivedLabel = UILabel()
    lazy var archiveSwitch = UISwitch()
    lazy var colorView = UIView()
    var collectionView: UICollectionView!
    lazy var deleteButton = UIButton(type: .system)
    lazy var deleteBorderView = UIView()
    
    private var bottomConstraint: NSLayoutConstraint!
    
    var onDelete:(() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        collectionView.allowsMultipleSelection = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(onDelete(_:)), for: .touchUpInside)
        
        deleteBorderView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1991362236)
        deleteBorderView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(typeControl)
        addSubview(titleField)
        addSubview(titleBorderView)
        addSubview(archivedLabel)
        addSubview(archiveSwitch)
        addSubview(colorView)
        addSubview(collectionView)
        addSubview(deleteButton)
        addSubview(deleteBorderView)
        
        bottomConstraint = deleteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            typeControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            typeControl.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            typeControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            titleField.topAnchor.constraint(equalTo: typeControl.bottomAnchor, constant: 40),
            titleField.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            titleField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
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
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            deleteBorderView.widthAnchor.constraint(equalTo: deleteButton.widthAnchor),
            deleteBorderView.heightAnchor.constraint(equalToConstant: 0.5),
            deleteBorderView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor),
            
            deleteButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            bottomConstraint,
            deleteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardChange(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadCategory(category: CategoryViewModel?) {
        if let category = category {
            typeControl.selectedSegmentIndex = category.type.rawValue
            titleField.text = category.title
            archiveSwitch.isOn = category.isArchived
            colorView.backgroundColor = UIColor(hexString: category.hexColor)
            
            let index = kCOLORS.firstIndex(of: category.hexColor)!
//            collectionView.reloadData()
//            collectionView.layoutIfNeeded()
            collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .right)
        } else {
            typeControl.selectedSegmentIndex = 0
            deleteBorderView.isHidden = true
            deleteButton.isHidden = true
            titleField.becomeFirstResponder()
            archiveSwitch.isOn = false
            colorView.backgroundColor = UIColor(hexString: kCOLORS.first!)
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !titleField.frame.contains(point) {
            endEditing(true)
        }
        
        return super.hitTest(point, with: event)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension CategoryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.colorView.backgroundColor = UIColor(hexString: kCOLORS[indexPath.row])
        }
    }
    
}

extension CategoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 50, height: 50)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        20
    }
    
}

extension CategoryView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        kCOLORS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let color = kCOLORS[indexPath.row]
        
        cell.backgroundColor = UIColor(hexString: color)
        
        return cell
    }
    
}

private extension CategoryView {
    
    @objc
    func onKeyboardChange(_ sender: Notification) {
        guard !deleteButton.isHidden else {
            return
        }
        
        guard let endFrame = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.bottomConstraint.constant = endFrame.origin.y >= self.frame.height ? 0 : -endFrame.height
            self.layoutIfNeeded()
        }
    }
    
    @objc
    func onDelete(_ sender: UIButton) {
        onDelete?()
    }
    
}
