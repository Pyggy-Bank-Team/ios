//
//  ReportsSceneAssembly.swift
//  PiggyBank
//

import Swinject
import UIKit

class ReportsSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(ReportsDataSource.self, initializer: ReportsRemoteDataSource.init)
        container.autoregister(ReportsRepository.self, initializer: ReportsDataRepository.init)
        container.autoregister(GetReportsByCategoryUseCase.self, initializer: GetReportsByCategoryUseCase.init)
        container.autoregister(ReportsPresenter.self, initializer: ReportsPresenter.init)
        container.register(ReportsViewController.self) { _ in ReportsViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(ReportsPresenter.self)
            }
    }
}
