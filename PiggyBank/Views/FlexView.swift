import UIKit

final class FlexView: UIView {

    private var widths: [CGFloat] = []
    private var activityIndicator = UIActivityIndicatorView(style: .gray)

    override init(frame: CGRect) {
        super.init(frame: frame)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 15),
            activityIndicator.widthAnchor.constraint(equalToConstant: 15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with items: [String]) -> CGFloat {
        let labelHeight: CGFloat = 25
        let labelTopMargin: CGFloat = 10
        let labelLeftMargin: CGFloat = 10

        var result = labelHeight

        //First label
        var lastLabel = UILabel(frame: .zero)
        let text = items.first!
        let attributed = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 17)])
        let bounding = attributed.boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: labelHeight), options: .usesLineFragmentOrigin, context: nil)
        let labelWidth = bounding.width + 10
        lastLabel.frame.size = CGSize(width: labelWidth, height: labelHeight)
        lastLabel.text = items.first
        lastLabel.textAlignment = .center
        lastLabel.backgroundColor = .systemBlue
        lastLabel.textColor = .white
        lastLabel.clipsToBounds = true
        lastLabel.layer.cornerRadius = 5
        addSubview(lastLabel)

        for i in 1 ..< items.count {
            let newLabel = UILabel(frame: .zero)
            let text = items[i]
            let attributed = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 17)])
            let bounding = attributed.boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: labelHeight), options: .usesLineFragmentOrigin, context: nil)
            let labelWidth = bounding.width + 10

            let needSpace = labelWidth + labelLeftMargin
            let availableSpace = frame.width - (lastLabel.frame.minX + lastLabel.frame.width)

            if needSpace < availableSpace {
                let origin = CGPoint(x: lastLabel.frame.minX + lastLabel.frame.width + labelLeftMargin, y: lastLabel.frame.minY)
                newLabel.frame = CGRect(origin: origin, size: CGSize(width: labelWidth, height: labelHeight))
            } else {
                result = result + labelHeight + labelTopMargin
                newLabel.frame = CGRect(x: 0, y: lastLabel.frame.maxY + labelTopMargin, width: labelWidth, height: labelHeight)
            }

            newLabel.text = text
            newLabel.textAlignment = .center
            newLabel.backgroundColor = .white
            newLabel.textColor = .black
            newLabel.clipsToBounds = true
            newLabel.layer.cornerRadius = 5
            newLabel.layer.borderWidth = 1
            newLabel.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
            addSubview(newLabel)
            lastLabel = newLabel
        }

        for subview in subviews {
            if subview is UILabel {
                widths.append(subview.frame.width)
                subview.frame.size.width = 0
            }
        }

        return result
    }

    func updateViews() {
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.removeFromSuperview()

            for i in 0 ..< self.subviews.count {
                let subview = self.subviews[i]

                if subview is UILabel {
                    let width = self.widths[i]
                    subview.frame.size.width = width
                }
            }
        }
    }

}
