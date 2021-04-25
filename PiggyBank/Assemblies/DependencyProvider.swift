//
//  DependencyProvider.swift
//  PiggyBank
//

import Swinject

final class DependencyProvider {

    static let shared = DependencyProvider()

    private init() {}

    private let container = Container()
    private(set) lazy var assembler: Assembler = {
        // order is matter
        Assembler([
            StartSceneAssembly(),
            AccountsAssembly(),
            CategoriesAssembly(),
            OperationsSceneAssembly(),
            ProfileSceneAssembly(),
            ReportsSceneAssembly(),
            OperationSceneAssembly()
        ], container: container)
    }()
}
