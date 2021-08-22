//
//  PiggyTextField.swift
//  PiggyBank
//

import UIKit

final class PiggyTextField: UITextField, UITextFieldDelegate {

    enum FieldType {
        case text
        case email
        case password
    }

    private let fieldType: FieldType
    private let underlineView: UIView = {
        let underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        underlineView.backgroundColor = UIColor(hexString: "#A0A3BD")
        return underlineView
    }()

    private let hidePasswordButton: UIButton = {
        let hidePasswordButton = UIButton()
        hidePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        hidePasswordButton.setImage(#imageLiteral(resourceName: "hide").withRenderingMode(.alwaysTemplate), for: .normal)
        hidePasswordButton.tintColor = UIColor(hexString: "#BDBDBD")
        hidePasswordButton.addTarget(self, action: #selector(onHidePasswordButtonPressed), for: .touchUpInside)
        return hidePasswordButton
    }()

    init(type: FieldType = .text) {
        self.fieldType = type
        super.init(frame: .zero)

        delegate = self
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        } else {
            // iOS 11: Disables the autofill accessory view.
            textContentType = .init(rawValue: "")
        }

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        addSubview(underlineView)
        NSLayoutConstraint.activate([
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -4.0),
            underlineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4.0),
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4.0)
        ])

        if fieldType == .password {
            addSubview(hidePasswordButton)
            NSLayoutConstraint.activate([
                hidePasswordButton.heightAnchor.constraint(equalToConstant: 15.0),
                hidePasswordButton.widthAnchor.constraint(equalToConstant: 15.0),
                hidePasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                hidePasswordButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }

    @objc
    private func onHidePasswordButtonPressed(sender: AnyObject) {
        guard sender.isEqual(hidePasswordButton) else {
            return
        }
        isSecureTextEntry.toggle()
        let buttonImage = isSecureTextEntry ? #imageLiteral(resourceName: "hide").withRenderingMode(.alwaysTemplate) : #imageLiteral(resourceName: "show").withRenderingMode(.alwaysTemplate)
        hidePasswordButton.setImage(buttonImage, for: .normal)
    }
}

extension PiggyTextField {

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(origin: bounds.origin, size: CGSize(width: bounds.width - 20, height: bounds.height))
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        underlineView.backgroundColor = UIColor(hexString: "#0D1C36")
        hidePasswordButton.tintColor = UIColor(hexString: "#0D1C36")
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        underlineView.backgroundColor = UIColor(hexString: "#BDBDBD")
        hidePasswordButton.tintColor = UIColor(hexString: "#BDBDBD")
        return true
    }

}
