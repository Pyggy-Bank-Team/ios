//
//  ReportsViewController.swift
//  PiggyBank
//

import UIKit
import Charts

public final class ReportsViewController: UIViewController {
    var presenter: ReportsPresenter!

    private lazy var startDateLabel: UILabel = {
        let startDateLabel = UILabel()
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.text = presenter.reportViewModel.startDate.stringFromDate(format: "yyyy-MM-dd")
        startDateLabel.textAlignment = .center
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onStartDatePressed))
        startDateLabel.addGestureRecognizer(gestureRecognizer)
        return startDateLabel
    }()

    private lazy var endDateLabel: UILabel = {
        let endDateLabel = UILabel()
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.text = presenter.reportViewModel.endDate.stringFromDate(format: "yyyy-MM-dd")
        endDateLabel.textAlignment = .center
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onEndDatePressed))
        endDateLabel.addGestureRecognizer(gestureRecognizer)
        return endDateLabel
    }()

    private lazy var categoryControl: UISegmentedControl = {
        let categoryControl = UISegmentedControl(items: ["Outcome", "Income"])
        categoryControl.translatesAutoresizingMaskIntoConstraints = false
        categoryControl.selectedSegmentIndex = 0
        categoryControl.addTarget(self, action: #selector(onCategoryChange), for: .valueChanged)
        return categoryControl
    }()

    private lazy var chartView: PieChartView = {
        let chartView = PieChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.drawCenterTextEnabled = false
        chartView.drawEntryLabelsEnabled = false
        chartView.rotationEnabled = false
        chartView.transparentCircleRadiusPercent = 0.0
        chartView.legend.enabled = false
        return chartView
    }()

    private lazy var totalLabel: UILabel = {
        let totalLabel = UILabel()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.textAlignment = .center
        return totalLabel
    }()

    private lazy var categoryList: UITableView = {
        let categoryList = UITableView()
        categoryList.translatesAutoresizingMaskIntoConstraints = false
        categoryList.delegate = self
        categoryList.dataSource = self
        categoryList.allowsSelection = false
        categoryList.separatorStyle = .none
        categoryList.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return categoryList
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reports"

        configureCategoryControl()
        configureStartDateLabel()
        configureEndDateLabel()
        configureChartView()
        configureTotalLabel()
        configureCategoryList()

        presenter.prepareData()
    }

    private func configureCategoryControl() {
        view.addSubview(categoryControl)
        NSLayoutConstraint.activate([
            categoryControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            categoryControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    private func configureStartDateLabel() {
        view.addSubview(startDateLabel)
        NSLayoutConstraint.activate([
            startDateLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            startDateLabel.topAnchor.constraint(equalTo: categoryControl.bottomAnchor, constant: 20),
            startDateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    private func configureEndDateLabel() {
        view.addSubview(endDateLabel)
        NSLayoutConstraint.activate([
            endDateLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor),
            endDateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    private func configureChartView() {
        view.addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -148.0),
            chartView.heightAnchor.constraint(equalTo: chartView.widthAnchor),
            chartView.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 20),
            chartView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    private func configureTotalLabel() {
        view.addSubview(totalLabel)
        NSLayoutConstraint.activate([
            totalLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            totalLabel.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20),
            totalLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    private func configureCategoryList() {
        view.addSubview(categoryList)
        NSLayoutConstraint.activate([
            categoryList.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            categoryList.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 20),
            categoryList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc
    private func onCategoryChange(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        presenter.onCategoryTypeChange(type: CategoryViewModel.CategoryType(rawValue: index) ?? .outcome)
    }

    @objc
    private func onStartDatePressed() {

    }

    @objc
    private func onEndDatePressed() {

    }
}

extension ReportsViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        41.0
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.reportViewModel.categoryList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let category = presenter.reportViewModel.categoryList[indexPath.row]
        cell.textLabel?.text = "\(category.name): \(category.amount)"
        cell.backgroundColor = category.color
        return cell
    }
}

// MARK: - UI update

extension ReportsViewController {

    func updateView() {
        totalLabel.text = "Total: \(presenter.reportViewModel.total)"
        categoryList.reloadData()
        updateChartData()
    }

    private func updateChartData() {
        var colors: [UIColor] = []
        let entries = presenter.reportViewModel.categoryList.map({ category -> PieChartDataEntry in
            colors.append(category.color)
            return PieChartDataEntry(value: Double(category.amount))
        })

        let set = PieChartDataSet(entries: entries, label: "")
        set.colors = colors
        set.drawIconsEnabled = false
        set.drawValuesEnabled = false
        set.highlightEnabled = false
        set.form = .none
        set.selectionShift = 0

        let data = PieChartData(dataSet: set)
        chartView.data = data
        // FIXME: need to find most suitable animation
//        chartView.animate(xAxisDuration: 0.3, easingOption: .easeInCubic)
    }
}
