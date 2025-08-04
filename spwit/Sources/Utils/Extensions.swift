//
//  Extensions.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

import UIKit

extension Int {
    var formattedRupiah: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp"
        formatter.currencyGroupingSeparator = "."
        formatter.currencyDecimalSeparator = ","
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "id_ID")
        return formatter.string(from: NSNumber(value: self)) ?? "Rp0"
    }
}
