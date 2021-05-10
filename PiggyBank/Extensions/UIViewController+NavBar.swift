//
//  UIViewController+NavBar.swift
//  PiggyBank
//

import UIKit

extension UIViewController {
    func configureNavigationBar(backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = backgoundColor
            navBarAppearance.shadowImage = nil // line
            navBarAppearance.shadowColor = .clear // line
            navBarAppearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 22.0, weight: .semibold)]

            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgoundColor
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 22.0, weight: .semibold)]
        }
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.isTranslucent = false
    }
}
