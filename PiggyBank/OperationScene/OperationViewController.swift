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
    private lazy var totalBorder = UIView()
    private lazy var operationTypeControl = UISegmentedControl()
    private lazy var dateLabel = UILabel()
    private lazy var datePicker = UIDatePicker()

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
        totalField.textColor = .green
        totalField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalField)

        totalBorder.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        totalBorder.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(totalBorder)

        operationTypeControl.insertSegment(withTitle: "Outcome", at: 0, animated: false)
        operationTypeControl.insertSegment(withTitle: "Income", at: 1, animated: false)
        operationTypeControl.insertSegment(withTitle: "Transfer", at: 2, animated: false)
        operationTypeControl.selectedSegmentIndex = 0
//        let image = UIImage.imageFrom(color: .white)
//        let blackImage = UIImage.imageFrom(color: .systemBlue)
//        operationTypeControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
//        operationTypeControl.setBackgroundImage(blackImage, for: .selected, barMetrics: .default)
//        operationTypeControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
//        operationTypeControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//        operationTypeControl.layer.borderWidth = 1
//        operationTypeControl.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        if #available(iOS 13.0, *) {
            operationTypeControl.selectedSegmentTintColor = .systemBlue
            operationTypeControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        }
        operationTypeControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(operationTypeControl)

        dateLabel.text = "Date"
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)

        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .compact
        }
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.date = Date()
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            headerLabel.centerYAnchor.constraint(equalTo: backButton.safeAreaLayoutGuide.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: backButton.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            totalField.topAnchor.constraint(equalTo: headerLabel.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            totalField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            totalField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),

            totalBorder.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            totalBorder.widthAnchor.constraint(equalTo: totalField.safeAreaLayoutGuide.widthAnchor),
            totalBorder.topAnchor.constraint(equalTo: totalField.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            totalBorder.heightAnchor.constraint(equalToConstant: 1),

            operationTypeControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            operationTypeControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            operationTypeControl.topAnchor.constraint(equalTo: totalBorder.safeAreaLayoutGuide.bottomAnchor, constant: 20),

            dateLabel.leadingAnchor.constraint(equalTo: totalBorder.safeAreaLayoutGuide.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: operationTypeControl.safeAreaLayoutGuide.bottomAnchor, constant: 50),

            datePicker.leadingAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leadingAnchor),
            datePicker.topAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.topAnchor, constant: 25),
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
