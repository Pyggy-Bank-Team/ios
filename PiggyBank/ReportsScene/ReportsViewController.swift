//
//  ReportsViewController.swift
//  PiggyBank
//

import Charts
import UIKit

final class ReportsViewController: UIViewController {
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

    private let controlIndexToCategoryType: [Int: CategoryViewModel.CategoryType] = [
        0: .outcome,
        1: .income
    ]

    private lazy var categoryControl: PiggySegmentedControl = {
        let controlFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 28.0)
        let categoryControl = PiggySegmentedControl(frame: controlFrame)
        categoryControl.translatesAutoresizingMaskIntoConstraints = false
        categoryControl.setSegmentedWith(items: ["Outcome", "Income"])
        categoryControl.padding = -2.0
        categoryControl.titlesFont = .systemFont(ofSize: 16.0, weight: .regular)
        categoryControl.textColor = UIColor(hexString: "#4E4B66")
        categoryControl.selectedTextColor = UIColor(hexString: "#0063B1")
        categoryControl.thumbViewColor = UIColor(hexString: "#0063B1")
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

    private var totalValueLabel: UILabel!
    private lazy var totalStackView: UIStackView = {
        let totalTitleLabel = UILabel()
        totalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalTitleLabel.font = .systemFont(ofSize: 15.0, weight: .medium)
        totalTitleLabel.text = "Total"

        totalValueLabel = UILabel()
        totalValueLabel.translatesAutoresizingMaskIntoConstraints = false
        totalValueLabel.font = .systemFont(ofSize: 15.0, weight: .medium)

        let totalStackView = UIStackView(arrangedSubviews: [totalTitleLabel, totalValueLabel])
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        return totalStackView
    }()

    private let dividerView: UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        dividerView.backgroundColor = UIColor(hexString: "#D6D8E7")
        return dividerView
    }()

    private lazy var categoryList: UITableView = {
        let categoryList = UITableView()
        categoryList.translatesAutoresizingMaskIntoConstraints = false
        categoryList.delegate = self
        categoryList.dataSource = self
        categoryList.allowsSelection = false
        categoryList.separatorStyle = .none
        categoryList.showsVerticalScrollIndicator = false
        categoryList.register(
            CategoryOperationInfoTableViewCell.self,
            forCellReuseIdentifier: CategoryOperationInfoTableViewCell.identifier
        )
        return categoryList
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Reports"

        configureCategoryControl()
        configureStartDateLabel()
        configureEndDateLabel()
        configureChartView()
        configureTotalStackView()
        configureDividerView()
        configureCategoryList()

        presenter.prepareData()
    }

    private func configureCategoryControl() {
        view.addSubview(categoryControl)
        NSLayoutConstraint.activate([
            categoryControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50.0),
            categoryControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func configureStartDateLabel() {
        view.addSubview(startDateLabel)
        NSLayoutConstraint.activate([
            startDateLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            startDateLabel.topAnchor.constraint(equalTo: categoryControl.bottomAnchor, constant: 20),
            startDateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func configureEndDateLabel() {
        view.addSubview(endDateLabel)
        NSLayoutConstraint.activate([
            endDateLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor),
            endDateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func configureChartView() {
        view.addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -148.0),
            chartView.heightAnchor.constraint(equalTo: chartView.widthAnchor),
            chartView.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 20),
            chartView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func configureTotalStackView() {
        view.addSubview(totalStackView)
        NSLayoutConstraint.activate([
            totalStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50),
            totalStackView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20),
            totalStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func configureDividerView() {
        view.addSubview(dividerView)
        NSLayoutConstraint.activate([
            dividerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50),
            dividerView.topAnchor.constraint(equalTo: totalStackView.bottomAnchor, constant: 14.0),
            dividerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func configureCategoryList() {
        view.addSubview(categoryList)
        NSLayoutConstraint.activate([
            categoryList.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50.0),
            categoryList.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            categoryList.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 15),
            categoryList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc
    private func onCategoryChange(sender: UIButton) {
        let index = categoryControl.selectedSegmentIndex
        presenter.onCategoryTypeChange(type: controlIndexToCategoryType[index] ?? .outcome)
    }

    @objc
    private func onStartDatePressed() {

    }

    @objc
    private func onEndDatePressed() {

    }
}

extension ReportsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        62.0
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.reportViewModel.categoryList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryOperationInfoTableViewCell.identifier,
                for: indexPath
        ) as? CategoryOperationInfoTableViewCell else {
            return UITableViewCell()
        }

        let category = presenter.reportViewModel.categoryList[indexPath.row]
        let amount = "\(presenter.reportViewModel.sign) \(category.amount)"
        cell.build(color: category.color, name: category.name, amount: amount)
        return cell
    }
}

// MARK: - UI update

extension ReportsViewController {

    func updateView() {
        totalValueLabel.text = "\(presenter.reportViewModel.sign) \(presenter.reportViewModel.total)"
        categoryList.reloadData()
        updateChartData()
    }

    private func updateChartData() {
        var colors: [UIColor] = []
        let entries = presenter
            .reportViewModel
            .categoryList
            .map { category -> PieChartDataEntry in
                colors.append(category.color)
                return PieChartDataEntry(value: Double(category.amount))
            }

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
