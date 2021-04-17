//
//  ReportsSceneAssembly.swift
//  PiggyBank
//

import UIKit

public final class ReportsSceneAssembly {
    func build() -> UIViewController {
        let viewController = ReportsViewController()
        let presenter = ReportsPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
