//
//  OperationViewController.swift
//  PiggyBank
//
//  Created by Dave Chupreev on 11/22/20.
//  Copyright © 2020 Dave Chupreev. All rights reserved.
//

import UIKit

class OperationViewController: UIViewController {
    
    var presenter: OperationPresenter!
    
    private lazy var backButton = UIButton(type: .system)
    private lazy var headerLabel = UILabel()
    private lazy var totalField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        
        backButton.setImage(#imageLiteral(resourceName: "arrow-left"), for: .normal)
        backButton.addTarget(self, action: #selector(onBack(_:)), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .black
        backButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.addSubview(backButton)
        
        headerLabel.text = "Add new operation"
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        headerLabel.font = .boldSystemFont(ofSize: 17)
        view.addSubview(headerLabel)
        
        totalField.placeholder = "Enter total.."
        totalField.font = .systemFont(ofSize: 25)
        totalField.tintColor = .green
        totalField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalField)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            headerLabel.centerYAnchor.constraint(equalTo: backButton.safeAreaLayoutGuide.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: backButton.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            totalField.topAnchor.constraint(equalTo: headerLabel.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            totalField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            totalField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9)
            
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

private extension OperationViewController {
    
    @objc func onBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
