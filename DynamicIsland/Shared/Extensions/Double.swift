//
//  Double.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import Foundation

extension Double {
    private var currencyPriceFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        return formatter
    }
    private var percentageFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    func toUSDCurrency() -> String {
        return currencyPriceFormatter.string(for: abs(Double(self))) ?? "$0.00"
    }
    
    func toPercentString() -> String {
        return "\(self >= 0 ? "+":"-" )%"+(percentageFormatter.string(for: self) ?? "0.00").replacingOccurrences(of: "-", with: "")
    }
}
