//
//  HomeSceneAssembly.swift
//  PiggyBank
//

import Swinject
import UIKit

class HomeSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(HomePresenter.self, initializer: HomePresenter.init)
        container.register(HomeViewController.self) { _ in HomeViewController() }
            .initCompleted { resolver, controller in
                controller.presenter = resolver.resolve(HomePresenter.self)
            }
    }
}
