import UIKit

protocol FlexViewDelegate: AnyObject {

    func flexView(_ flexView: FlexView, didSelectRowAt index: Int)
}

public final class FlexView: UIView {

    private var activityIndicator = UIActivityIndicatorView(style: .gray)

    private var allLabels: [UILabel] = []
    private var selectedLabel: UILabel?
    private var labelProcessedWidth: [CGFloat] = []

    weak var delegate: FlexViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        activityIndicator.tag = -1
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

    func update(with titles: [String]) -> CGFloat {
        let labelHeight: CGFloat = 25
        let labelTopMargin: CGFloat = 10
        let labelInnerPadding: CGFloat = 10

        var result = labelHeight
        var lastFrame = CGRect.zero
        var counter = 0

        for title in titles {
            let newLabel = UILabel(frame: .zero)
            let attributed = NSAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 17)])
            let bounding = attributed.boundingRect(with: CGSize(width: .greatestFiniteMagnitude, height: labelHeight), options: .usesLineFragmentOrigin, context: nil)
            let labelWidth = bounding.width + labelInnerPadding

            let labelLeftMargin: CGFloat = counter == 0 ? 0 : 10

            let needSpace = labelWidth + labelLeftMargin
            let availableSpace = frame.width - (lastFrame.minX + lastFrame.width)

            if needSpace < availableSpace {
                let origin = CGPoint(x: lastFrame.minX + lastFrame.width + labelLeftMargin, y: lastFrame.minY)
                newLabel.frame = CGRect(origin: origin, size: CGSize(width: labelWidth, height: labelHeight))
            } else {
                result = result + labelHeight + labelTopMargin
                newLabel.frame = CGRect(x: 0, y: lastFrame.maxY + labelTopMargin, width: labelWidth, height: labelHeight)
            }

            newLabel.text = title
            newLabel.textAlignment = .center
            newLabel.backgroundColor = .white
            newLabel.textColor = .black
            newLabel.clipsToBounds = true
            newLabel.layer.cornerRadius = 5
            newLabel.layer.borderWidth = 1
            newLabel.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
            newLabel.tag = counter
            addSubview(newLabel)

            lastFrame = newLabel.frame
            counter += 1

            labelProcessedWidth.append(newLabel.frame.width)
            newLabel.frame.size.width = 0
            allLabels.append(newLabel)
        }

        return result
    }

    func updateViews() {
        UIView.animate(withDuration: 0.3) {
            self.activityIndicator.removeFromSuperview()
            self.allLabels.enumerated().forEach { $1.frame.size.width = self.labelProcessedWidth[$0] }
        }
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        
        guard let targetLabel = allLabels.first(where: { $0.frame.contains(location) }) else {
            return
        }

        select(view: targetLabel)
    }

    func select(view: UILabel) {
        if let selected = selectedLabel {
            if selected == view {
                return
            }

            selected.backgroundColor = .white
            selected.textColor = .black
            selected.layer.borderWidth = 1
            selected.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        }

        view.backgroundColor = .systemBlue
        view.textColor = .white
        view.layer.borderWidth = 0

        selectedLabel = view
        delegate?.flexView(self, didSelectRowAt: view.tag)
    }

}
