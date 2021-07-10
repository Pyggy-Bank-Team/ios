//
//  DependencyProvider.swift
//  PiggyBank
//

import Swinject
import UIKit

enum ScreenType {
    case start
    case home
    case login

    case accounts
    case categories
    case operations
    case reports

    case auth(AuthSceneMode)
    case profile
    case account(DomainAccountModel?)
    case currency(String, String)
    case category(DomainCategoryModel?)
    case operation(DomainOperationModel?)
}

final class DependencyProvider {

    static let shared = DependencyProvider()
    // must be private
    private init() {}

    private let container = Container()
    private(set) lazy var assembler: Assembler = {
        // order is matter
        Assembler([
            StartSceneAssembly(),
            HomeSceneAssembly(),
            LoginSceneAssembly(),
            AccountsAssembly(),
            CategoriesAssembly(),
            OperationsSceneAssembly(),
            ProfileSceneAssembly(),
            ReportsSceneAssembly(),
            OperationSceneAssembly()
        ], container: container)
    }()

    private var resolver: Resolver {
        assembler.resolver
    }

    // swiftlint:disable cyclomatic_complexity
    func get(screen: ScreenType) -> UIViewController {
        let retViewController: UIViewController?
        switch screen {
        case .start:
            retViewController = resolver.resolve(StartViewController.self)
        case .home:
            retViewController = resolver.resolve(HomeViewController.self)
        case .login:
            retViewController = resolver.resolve(LoginViewController.self)
        case .accounts:
            retViewController = resolver.resolve(AccountsViewController.self)
        case .categories:
            retViewController = resolver.resolve(CategoriesViewController.self)
        case .operations:
            retViewController = resolver.resolve(OperationsViewController.self)
        case .reports:
            retViewController = resolver.resolve(ReportsViewController.self)
        case .auth(let mode):
            assembler.apply(assembly: AuthSceneAssembly(mode: mode))
            retViewController = resolver.resolve(AuthViewController.self)
        case .profile:
            retViewController = resolver.resolve(ProfileViewController.self)
        case .account(let model):
            assembler.apply(assembly: AccountSceneAssembly(accountDomainModel: model))
            retViewController = resolver.resolve(AccountViewController.self)
        case let .currency(nickname, password):
            assembler.apply(assembly: BaseCurrencySceneAssembly(initialNickname: nickname, initialPassword: password))
            retViewController = resolver.resolve(BaseCurrencyViewController.self)
        case .category(let model):
            assembler.apply(assembly: CategorySceneAssembly(categoryDomainModel: model))
            retViewController = resolver.resolve(CategoryViewController.self)
        case .operation:
            retViewController = resolver.resolve(OperationViewController.self)
        }

        guard let retVC = retViewController else {
            fatalError("\(screen) must be resolved")
        }
        return retVC
    }
}
