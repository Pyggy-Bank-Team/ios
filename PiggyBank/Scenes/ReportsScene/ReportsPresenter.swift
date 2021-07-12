//
//  ReportsPresenter.swift
//  PiggyBank
//

import UIKit

public final class ReportsPresenter {

    private(set) var reportViewModel = ReportViewModel(type: .outcome,
                                                       startDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!,
                                                       endDate: Calendar.current.date(byAdding: .year, value: 1, to: Date())!,
                                                       total: 0,
                                                       categoryList: [])

    private weak var view: ReportsViewController?
    private let getReportsByCategoryUseCase: GetReportsByCategoryUseCase?

    init(view: ReportsViewController?, getReportsByCategoryUseCase: GetReportsByCategoryUseCase?) {
        self.view = view
        self.getReportsByCategoryUseCase = getReportsByCategoryUseCase
    }

    func prepareData() {
        executeUseCase()
    }

    func onIntervalChange(fromDate: Date, toDate: Date) {
        reportViewModel.startDate = fromDate
        reportViewModel.endDate = fromDate > toDate ? fromDate : toDate
        executeUseCase()
    }

    func onCategoryTypeChange(type: DomainCategoryModel.CategoryType) {
        reportViewModel.type = type
        executeUseCase()
    }

    private func executeUseCase() {
        let category = DomainCategoryModel.CategoryType(rawValue: reportViewModel.type.rawValue) ?? .income
        getReportsByCategoryUseCase?.execute(category: category, from: reportViewModel.startDate, to: reportViewModel.endDate) { [weak self] response in
            guard let self = self else {
                return
            }

            switch response {
            case .success(let items):
                self.reportViewModel.categoryList = items.map({ GrandConverter.convertToViewModel(domainModel: $0) })
                self.reportViewModel.total = items.reduce(0, { $0 + $1.amount })
                DispatchQueue.main.async {
                    self.view?.updateView()
                }
            case .error(let error):
                print("Error: \(error)")
            }
        }
    }
}
