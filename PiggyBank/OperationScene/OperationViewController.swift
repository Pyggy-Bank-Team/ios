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

    var items: [String] = ["СБЕР Банк", "Карта Тинькофф", "Заначка под подушкой", "Счет на Кипре"]
    
    private lazy var backButton = UIButton(type: .system)
    private lazy var headerLabel = UILabel()
    private lazy var totalField = UITextField()
    private lazy var totalBorder = UIView()
    private lazy var operationTypeControl = UISegmentedControl()
    private lazy var dateLabel = UILabel()
    private lazy var datePicker = UIDatePicker()
    private lazy var fromLabel = UILabel()

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
        totalField.keyboardType = .numberPad
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

        fromLabel.text = "From"
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fromLabel)
        
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
            datePicker.topAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),

            fromLabel.leadingAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leadingAnchor),
            fromLabel.topAnchor.constraint(equalTo: datePicker.safeAreaLayoutGuide.bottomAnchor, constant: 50),
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let leftMargin = fromLabel.frame.minX
        let topMargin = fromLabel.frame.maxY + 10
        let width = view.frame.width - (leftMargin * 2)

        let labelHeight: CGFloat = 25
        let labelTopMargin: CGFloat = 10
        let labelLeftMargin: CGFloat = 10

        //Configure view
        let fromView = UIView(frame: CGRect(origin: CGPoint(x: leftMargin, y: topMargin), size: CGSize(width: width, height: labelHeight)))

        //First label
        var lastLabel = UILabel(frame: .zero)
        let text = items.first!
        let attributed = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 17)])
        let bounding = attributed.boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: labelHeight), options: .usesLineFragmentOrigin, context: nil)
        let labelWidth = bounding.width + 10
        lastLabel.frame.size = CGSize(width: labelWidth, height: labelHeight)
        lastLabel.text = items.first
        lastLabel.textAlignment = .center
        lastLabel.backgroundColor = .systemBlue
        lastLabel.textColor = .white
        lastLabel.clipsToBounds = true
        lastLabel.layer.cornerRadius = 5
        fromView.addSubview(lastLabel)

        for i in 1 ..< items.count {
            let newLabel = UILabel(frame: .zero)
            let text = items[i]
            let attributed = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 17)])
            let bounding = attributed.boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: labelHeight), options: .usesLineFragmentOrigin, context: nil)
            let labelWidth = bounding.width + 10

            let needSpace = labelWidth + labelLeftMargin
            let availableSpace = width - (lastLabel.frame.minX + lastLabel.frame.width)

            if needSpace < availableSpace {
                let origin = CGPoint(x: lastLabel.frame.minX + lastLabel.frame.width + labelLeftMargin, y: lastLabel.frame.minY)
                newLabel.frame = CGRect(origin: origin, size: CGSize(width: labelWidth, height: labelHeight))
            } else {
                fromView.frame.size = CGSize(width: fromView.frame.width, height: fromView.frame.height + labelHeight + labelTopMargin)
                newLabel.frame = CGRect(x: 0, y: lastLabel.frame.maxY + labelTopMargin, width: labelWidth, height: labelHeight)
            }

            newLabel.text = text
            newLabel.textAlignment = .center
            newLabel.backgroundColor = .white
            newLabel.textColor = .black
            newLabel.clipsToBounds = true
            newLabel.layer.cornerRadius = 5
            newLabel.layer.borderWidth = 1
            newLabel.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
            fromView.addSubview(newLabel)
            lastLabel = newLabel
        }

        view.addSubview(fromView)
    }
}

private extension OperationViewController {
    
    @objc func onBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
