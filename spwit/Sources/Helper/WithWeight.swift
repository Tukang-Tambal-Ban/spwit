//
//  WithWeight.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/3/25.
//


extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let fontDescriptor = self.fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
        return UIFont(descriptor: fontDescriptor, size: pointSize)
    }
}
