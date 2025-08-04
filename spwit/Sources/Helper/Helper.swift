//
//  Untitled.swift
//  spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
 
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = bounds
            gradientLayer.colors = colors.map(\.cgColor)

            // This makes it left to right, default is top to bottom
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0)

            let renderer = UIGraphicsImageRenderer(bounds: bounds)

            return renderer.image { ctx in
                gradientLayer.render(in: ctx.cgContext)
            }
        }
  
//    func applyGradient(colors: [UIColor], start: CGPoint = .zero, end: CGPoint = CGPoint(x: 1, y: 1)) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = colors.map { $0.cgColor }
//        gradientLayer.startPoint = start
//        gradientLayer.endPoint = end
//        gradientLayer.frame = bounds
//        gradientLayer.cornerRadius = layer.cornerRadius
//        layer.insertSublayer(gradientLayer, at: 0)
//    }
}
