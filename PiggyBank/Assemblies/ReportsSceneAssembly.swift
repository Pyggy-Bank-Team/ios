//
//  ReportsSceneAssembly.swift
//  PiggyBank
//

import Swinject
import UIKit

class ReportsSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(GetReportsByCategoryDataSource.self, initializer: GetReportsByCategoryRemoteDataSource.init)
        container.autoregister(GetReportsByCategoryRepository.self, initializer: GetReportsByCategoryDataRepository.init)
        container.autoregister(GetReportsByCategoryUseCase.self, initializer: GetReportsByCategoryUseCase.init)
        container.autoregister(ReportsPresenter.self, initializer: ReportsPresenter.init)
        container.register(ReportsViewController.self) { _ in ReportsViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(ReportsPresenter.self)
            }
    }
}
