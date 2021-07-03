//
//  ReportsViewController.swift
//  PiggyBank
//

import Charts
import UIKit

final class ReportsViewController: UIViewController {
    var presenter: ReportsPresenter!

    private lazy var headerStackView: UIStackView = {
        let headerStackView = UIStackView(arrangedSubviews: [screenTitle, startDateLabel, dashLabel, endDateLabel])
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.isUserInteractionEnabled = true
        return headerStackView
    }()

    private lazy var screenTitle: UILabel = {
        let screenTitle = UILabel()
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.text = "Reports"
        screenTitle.font = .systemFont(ofSize: 30.0, weight: .semibold)
        screenTitle.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return screenTitle
    }()

    private lazy var dashLabel: UILabel = {
        let dashLabel = UILabel()
        dashLabel.translatesAutoresizingMaskIntoConstraints = false
        dashLabel.text = " — "
        dashLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        dashLabel.textColor = UIColor(hexString: "#14142B")
        dashLabel.setContentHuggingPriority(.required, for: .horizontal)
        return dashLabel
    }()

    private lazy var startDateLabel: UILabel = {
        let startDateLabel = UILabel()
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.attributedText = getUnderlinedStringForDate(presenter.reportViewModel.startDate)
        startDateLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        startDateLabel.textColor = UIColor(hexString: "#14142B")
        startDateLabel.setContentHuggingPriority(.required, for: .horizontal)
        startDateLabel.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onStartDatePressed))
        startDateLabel.addGestureRecognizer(gestureRecognizer)
        return startDateLabel
    }()

    private lazy var endDateLabel: UILabel = {
        let endDateLabel = UILabel()
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.attributedText = getUnderlinedStringForDate(presenter.reportViewModel.endDate)
        endDateLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        endDateLabel.textColor = UIColor(hexString: "#14142B")
        endDateLabel.setContentHuggingPriority(.required, for: .horizontal)
        endDateLabel.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onEndDatePressed))
        endDateLabel.addGestureRecognizer(gestureRecognizer)
        return endDateLabel
    }()

    private let controlIndexToCategoryType: [Int: DomainCategoryModel.CategoryType] = [
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

        configureHeaderView()
        configureCategoryControl()
        configureChartView()
        configureTotalStackView()
        configureDividerView()
        configureCategoryList()

        presenter.prepareData()
    }

    private func configureHeaderView() {
        view.addSubview(headerStackView)
        NSLayoutConstraint.activate([
            headerStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50),
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            headerStackView.heightAnchor.constraint(equalToConstant: 45.0),
            headerStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func configureCategoryControl() {
        view.addSubview(categoryControl)
        NSLayoutConstraint.activate([
            categoryControl.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50),
            categoryControl.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
            categoryControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func configureChartView() {
        view.addSubview(chartView)
        NSLayoutConstraint.activate([
            chartView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -148.0),
            chartView.heightAnchor.constraint(equalTo: chartView.widthAnchor),
            chartView.topAnchor.constraint(equalTo: categoryControl.bottomAnchor, constant: 35),
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
        DatePickerDialog().show("Start Date",
                                doneButtonTitle: "Done",
                                cancelButtonTitle: "Cancel",
                                defaultDate: presenter.reportViewModel.startDate,
                                datePickerMode: .date) { [weak self] selectedStartDate in
            guard let selectedStartDate = selectedStartDate, let self = self else {
                return
            }
            self.presenter.onIntervalChange(fromDate: selectedStartDate, toDate: self.presenter.reportViewModel.endDate)
        }
    }

    @objc
    private func onEndDatePressed() {
        DatePickerDialog().show("End Date",
                                doneButtonTitle: "Done",
                                cancelButtonTitle: "Cancel",
                                defaultDate: presenter.reportViewModel.endDate,
                                minimumDate: presenter.reportViewModel.startDate,
                                datePickerMode: .date) { [weak self] selectedEndDate in
            guard let selectedEndDate = selectedEndDate, let self = self else {
                return
            }
            self.presenter.onIntervalChange(fromDate: self.presenter.reportViewModel.startDate, toDate: selectedEndDate)
        }
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
        let amount = "\(presenter.reportViewModel.sign) \(category.amount) \(category.currency)"
        cell.build(color: category.color, name: category.name, amount: amount)
        return cell
    }
}

// MARK: - UI update

extension ReportsViewController {

    func updateView() {
        let viewModel = presenter.reportViewModel
        startDateLabel.attributedText = getUnderlinedStringForDate(viewModel.startDate)
        endDateLabel.attributedText = getUnderlinedStringForDate(viewModel.endDate)
        totalValueLabel.text = "\(viewModel.sign) \(viewModel.total) \(viewModel.currency)"
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

// MARK: - Helpers

extension ReportsViewController {

    private func getUnderlinedStringForDate(_ date: Date) -> NSAttributedString {
        NSAttributedString(string: date.stringFromDate(format: "d MMM. YYYY"),
                           attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}
