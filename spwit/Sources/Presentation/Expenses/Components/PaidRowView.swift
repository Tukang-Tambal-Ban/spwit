import UIKit

class PaidRowView: UIView {
    let avatarView: InitialsCircleView
    let paidLabel = UILabel()
    let priceLabel = UILabel()
    let stripImage = UIImageView()

    // Use correct spelling: isPaid (not ispPaid)
    init(
        paidBy: String,
        amountText: String,
        isOwe: Bool,
        isPaid: Bool,
        bgColor: UIColor = .lightGreen,
        textColor: UIColor = .black,
        font: UIFont = .preferredFont(forTextStyle: .body)
    ) {
        let initials = paidBy
            .split(separator: " ")
            .compactMap { $0.first }
            .prefix(2)
            .map { String($0) }
            .joined()
            .uppercased()
        self.avatarView = InitialsCircleView(
            initials: initials,
            diameter: 44,
            bgColor: bgColor,
            textColor: textColor,
            font: font
        )
        super.init(frame: .zero)
        setup(paidBy: paidBy, amountText: amountText, isOwe: isOwe, isPaid: isPaid)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Update parameters to accept isOwe, isPaid, and paidBy
    private func setup(paidBy: String, amountText: String, isOwe: Bool, isPaid: Bool) {
        avatarView.translatesAutoresizingMaskIntoConstraints = false

        stripImage.image = UIImage(named: "stripLine.png")
        stripImage.contentMode = .scaleAspectFit
        stripImage.translatesAutoresizingMaskIntoConstraints = false

        // Build text based on the flags
        let word = isOwe ? "owe" : isPaid ? "paid" : ""
        paidLabel.text = "\(paidBy) \(word)"
        paidLabel.applyStyle(Fonts.callout.bold, color: .white)
        paidLabel.translatesAutoresizingMaskIntoConstraints = false

        priceLabel.text = amountText
        priceLabel.applyStyle(Fonts.callout.bold, color: .lightGreen)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stripImage)
        addSubview(avatarView)
        addSubview(paidLabel)
        addSubview(priceLabel)

        NSLayoutConstraint.activate([
            // Strip image: left, vertically centered, fixed width
            stripImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            stripImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            stripImage.widthAnchor.constraint(equalToConstant: 44),
            stripImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),

            // Avatar: right of strip, vertically centered
            avatarView.leadingAnchor.constraint(equalTo: stripImage.trailingAnchor, constant: 16),
            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 44),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),

            // Paid label: right of avatar
            paidLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8),
            paidLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            // Price label: right of paid label
            priceLabel.leadingAnchor.constraint(equalTo: paidLabel.trailingAnchor, constant: 3),
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -12)
        ])
    }
}

import SwiftUI

struct PaidRowViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let paidRow = PaidRowView(
            paidBy: "ND",
            amountText: "Rp500.000",
            isOwe: true,    // Try isOwe or isPaid here
            isPaid: false
        )
        paidRow.backgroundColor = .clear
        return paidRow
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct PaidRowView_Preview: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 17/255, green: 37/255, blue: 63/255)
                .edgesIgnoringSafeArea(.all)
            PaidRowViewPreview()
                .frame(height: 72)
                .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
