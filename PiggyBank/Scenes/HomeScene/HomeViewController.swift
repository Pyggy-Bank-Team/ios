//
//  HomeViewController.swift
//  PiggyBank
//

import UIKit

class HomeViewController: UIViewController {

    var smallPinkCircleViewLeftAnchorConstraint: NSLayoutConstraint!
    private let smallPinkCircleView: UIView = {
        let smallPinkCircleView = UIView()
        smallPinkCircleView.translatesAutoresizingMaskIntoConstraints = false
        smallPinkCircleView.layer.cornerRadius = 196.0 / 2
        smallPinkCircleView.backgroundColor = UIColor(hexString: "#CF5EA4", alpha: 0.1)
        return smallPinkCircleView
    }()

    var bigPinkCircleViewRightAnchorConstraint: NSLayoutConstraint!
    private let bigPinkCircleView: UIView = {
        let bigPinkCircleView = UIView()
        bigPinkCircleView.translatesAutoresizingMaskIntoConstraints = false
        bigPinkCircleView.layer.cornerRadius = 418.0 / 2
        bigPinkCircleView.backgroundColor = UIColor(hexString: "#CF5EA4", alpha: 0.1)
        return bigPinkCircleView
    }()

    private let piggyImageView: UIImageView = {
        let piggyImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        piggyImageView.translatesAutoresizingMaskIntoConstraints = false
        return piggyImageView
    }()

    private let piggyTitleImageView: UIImageView = {
        let piggyTitleImageView = UIImageView(image: #imageLiteral(resourceName: "piggybank"))
        piggyTitleImageView.translatesAutoresizingMaskIntoConstraints = false
        piggyTitleImageView.contentMode = .scaleAspectFit
        return piggyTitleImageView
    }()

    private let piggyDescriptionLabel: UILabel = {
        let piggyDescriptionLabel = UILabel()
        piggyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        piggyDescriptionLabel.text = "Free and easy to use budget planning application"
        piggyDescriptionLabel.font = .systemFont(ofSize: 18.0, weight: .regular)
        piggyDescriptionLabel.textColor = UIColor(hexString: "#4E4B66")
        piggyDescriptionLabel.numberOfLines = 0
        piggyDescriptionLabel.textAlignment = .center
        return piggyDescriptionLabel
    }()

    private lazy var loginButton: SecondaryButton = {
        let loginButton = SecondaryButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(onLoginPressed), for: .touchUpInside)
        return loginButton
    }()

    private lazy var registerButton: PrimaryButton = {
        let registerButton = PrimaryButton()
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Create Account", for: .normal)
        registerButton.addTarget(self, action: #selector(onRegisterPressed), for: .touchUpInside)
        return registerButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.addSubview(smallPinkCircleView)
        view.addSubview(bigPinkCircleView)
        view.addSubview(piggyImageView)
        view.addSubview(piggyTitleImageView)
        view.addSubview(piggyDescriptionLabel)
        view.addSubview(loginButton)
        view.addSubview(registerButton)

        smallPinkCircleViewLeftAnchorConstraint =
            smallPinkCircleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width)

        bigPinkCircleViewRightAnchorConstraint =
            bigPinkCircleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIScreen.main.bounds.width)

        NSLayoutConstraint.activate([
            smallPinkCircleView.widthAnchor.constraint(equalToConstant: 196.0),
            smallPinkCircleView.heightAnchor.constraint(equalToConstant: 196.0),
            smallPinkCircleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40.0),
            smallPinkCircleViewLeftAnchorConstraint,

            bigPinkCircleView.widthAnchor.constraint(equalToConstant: 418.0),
            bigPinkCircleView.heightAnchor.constraint(equalToConstant: 418.0),
            bigPinkCircleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 60.0),
            bigPinkCircleViewRightAnchorConstraint,

            piggyImageView.widthAnchor.constraint(equalToConstant: 60.0),
            piggyImageView.heightAnchor.constraint(equalToConstant: 60.0),
            piggyImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180.0),
            piggyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            piggyTitleImageView.heightAnchor.constraint(equalToConstant: 24.0),
            piggyTitleImageView.topAnchor.constraint(equalTo: piggyImageView.bottomAnchor, constant: 13.0),
            piggyTitleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            piggyDescriptionLabel.topAnchor.constraint(equalTo: piggyTitleImageView.bottomAnchor, constant: 30.0),
            piggyDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            piggyDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35.0),
            piggyDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35.0),

            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
            loginButton.heightAnchor.constraint(equalToConstant: 47.0),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            registerButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -10.0),
            registerButton.heightAnchor.constraint(equalToConstant: 47.0),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.0)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }

    @objc
    private func onLoginPressed() {
        // FIXME Implement me
        print("onLoginPressed")
    }

    @objc
    private func onRegisterPressed() {
        // FIXME Implement me
        print("onRegisterPressed")
    }

}

private extension HomeViewController {
    func animate() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0.5) {
            self.smallPinkCircleViewLeftAnchorConstraint.constant = 320.0
            self.bigPinkCircleViewRightAnchorConstraint.constant = -280.0
            self.view.layoutIfNeeded()
        }

        let animatedElements = [
            piggyImageView,
            piggyTitleImageView,
            piggyDescriptionLabel,
            loginButton,
            registerButton
        ]
        animatedElements.forEach { element in
            element.alpha = 0.0
            element.transform = .init(scaleX: 0.8, y: 0.8)
        }
        UIView.animate(withDuration: 0.5) {
            animatedElements.forEach { element in
                element.alpha = 1.0
                element.transform = .identity
            }
            self.view.layoutIfNeeded()
        }
    }
}
