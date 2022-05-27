//
//  DoubleExtensions.swift
//  ProductoList
//
//  Created by Maxeziowolf.
//

import UIKit

extension Double{
    func asMoney() -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return formattedTipAmount
        }
        else{
            return "\(self)"
        }
    }
}
