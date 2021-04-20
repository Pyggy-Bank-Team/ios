//
//  PiggySegmentedControl.swift
//  PiggySegmentedControl
//

import Foundation
import UIKit

public class PiggySegmentedControl: UIControl {

    // MARK: - static properties

    static let bottomLineThumbViewHeight: CGFloat = 2.0

    // MARK: - UI properties

    internal var buttons = [UIButton]()
    internal lazy var thumbView = UIView()
    internal lazy var underlineView = UIView()

    // Private datasources
    internal var buttonTitles: [String] = [] {
        didSet {
            updateView()
        }
    }

    // Public properties customize segmented control
    // change this public properties for customization

    // MARK: APPEREANCE
    public var selectedSegmentIndex = 0 {
        didSet {
            self.setSelectedIndex(to: selectedSegmentIndex)
        }
    }

    public var padding: CGFloat = 0 {
        didSet {
            self.updateView()
        }
    }

    // animation duration is 0.3 by default
    @IBInspectable public var animationDuration: CGFloat = 0.3
    @IBInspectable public var thumbViewAlpha: CGFloat = 1.0 {
        didSet {
            self.thumbView.alpha = thumbViewAlpha
        }
    }

    // segmented
    public var segmentedBackgroundColor: UIColor = .white {
        didSet {
            self.backgroundColor = segmentedBackgroundColor
        }
    }

    // thumbView
    public var thumbViewColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }

    // MARK: SEGMENTED CONTROL WITH TEXT
    public var textColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }

    public var selectedTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }

    /// Font for title in segmented control
    public var titlesFont: UIFont? {
        didSet {
            updateView()
        }
    }

    // MARK: SET SEGMENTED CONTROL DATASOURCES

    public func setSegmentedWith(items: [String]) {
        self.buttonTitles = items
    }

    // MARK: METHOD FOR UPDATE DATASOURCES
    public func updateSegmentedWith(items: [String]) {
        self.buttonTitles.removeAll()
        self.thumbView.alpha = 0
        self.selectedSegmentIndex = 0
        self.setSegmentedWith(items: items)

        UIView.animate(withDuration: 0.4) {
            self.updateView()
            self.thumbView.alpha = 1
        }
        // if we want to update the view based on the new selectedSegmentedIndex
        self.performAction()
    }

    // MARK: METHODS THAT WILL CREATE THE CONTROL BASED ON CUSTOMIZATION OF PROPERTIES

    // reset all views to clean state
    private func resetViews() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
    }

    // update the UI based on text/ images or colors
    private func updateView() {
        resetViews()
        clipsToBounds = false
        addSubview(thumbView)
        setupUnderlineView()
        setButtonsWithText()
        layoutButtonsOnStackView()
    }

    // all UI layout based on frames must be called on layoutSubviews
    override public func layoutSubviews() {
        super.layoutSubviews()

        self.backgroundColor = self.segmentedBackgroundColor
        setThumbView()
    }

    // MARK: THUMBVIEW LAYOUT
    private func setThumbView() {
        let thumbViewWidth = (bounds.width / CGFloat(buttons.count)) - padding * 2
        let thumbViewPositionX = padding
        let thumbViewPositionY = bounds.height - PiggySegmentedControl.bottomLineThumbViewHeight - padding

        thumbView.frame = CGRect(x: thumbViewPositionX,
                                 y: thumbViewPositionY,
                                 width: thumbViewWidth,
                                 height: PiggySegmentedControl.bottomLineThumbViewHeight)
        thumbView.layer.cornerRadius = 1.0
        thumbView.backgroundColor = thumbViewColor
    }

    // MARK: BUTTONS LAYOUTS
    private func layoutButtonsOnStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    private func setButtonsWithText() {
        guard !self.buttonTitles.isEmpty else {
            return
        }

        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = titlesFont
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
            // set the one that we want to show as selected by default
        }
        buttons[selectedSegmentIndex].setTitleColor(selectedTextColor, for: .normal)
    }

    private func setupUnderlineView() {
        addSubview(underlineView)
        sendSubviewToBack(underlineView)

        underlineView.clipsToBounds = false
        underlineView.backgroundColor = UIColor(hexString: "#A0A3BD")

        underlineView.frame = CGRect(x: padding,
                                     y: bounds.height - padding * 2 + 1,
                                     width: bounds.width,
                                     height: 1.0)
    }
}

// MARK: ACTIONS WHEN ITEM IS SELECTED IT HANDLES: ACTION - APPEREANCE - TRANSLATION
extension PiggySegmentedControl {

    // MARK: MAIN ACTION: .valueChanged

    /// This method handle the value change event
    internal func performAction() {
        sendActions(for: .valueChanged)
    }

    // MARK: CHANGING APPEREANCE OF BUTTON ON TAP

    /// Button tap event on segmented control
    /// - Parameter button: button at the index that was tapped
    @objc
    internal func buttonTapped(button: UIButton) {
        for (btnIndex, btn) in self.buttons.enumerated() where btn == button {
            selectedSegmentIndex = btnIndex
        }
    }

    @objc
    internal func setSelectedIndex(to index: Int) {
        let selectedBtn = self.buttons[index]

        for (btnIndex, btn) in self.buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == selectedBtn {
                moveThumbView(at: btnIndex)
                btn.setTitleColor(selectedTextColor, for: .normal)
            }
        }
        self.performAction()
    }

    // MARK: TRANSLATION OF THUMBVIEW WITH ANIMATION ON TAP

    private func moveThumbView(at index: Int) {
        let selectedStartPosition = index == 0 ? self.padding : bounds.width / CGFloat(buttons.count) * CGFloat(index) + self.padding
        UIView.animate(withDuration: TimeInterval(self.animationDuration)) {
            self.thumbView.frame.origin.x = selectedStartPosition
        }
    }
}
