//
//  HomeSceneAssembly.swift
//  PiggyBank
//

import Swinject
import UIKit

class HomeSceneAssembly: Assembly {

    func assemble(container: Container) {
        container.register(HomeViewController.self) { _ in HomeViewController() }
    }
}
