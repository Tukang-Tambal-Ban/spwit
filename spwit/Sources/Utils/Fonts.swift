import UIKit

enum Fonts {
    case title1
    case title3
    case callout
    case footnote
    case caption1
    case caption2

    var size: CGFloat {
        switch self {
        case .title1: return 28
        case .title3: return 20
        case .callout: return 16
        case .footnote: return 13
        case .caption1: return 12
        case .caption2: return 11
        }
    }

    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: weight)
    }
}

extension Fonts {
    var regular: UIFont { withWeight(.regular) }
    var medium: UIFont { withWeight(.medium) }
    var semibold: UIFont { withWeight(.semibold) }
    var bold: UIFont { withWeight(.bold) }
}

extension UILabel {
    func applyStyle(_ font: UIFont, color: UIColor? = nil) {
        self.font = font
        if let color = color {
            self.textColor = color
        }
    }
}
