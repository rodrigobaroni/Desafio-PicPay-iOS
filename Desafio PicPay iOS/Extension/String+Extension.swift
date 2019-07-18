//
//  String+Extension.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 09/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func removeSpecialCharacterIfFirst() -> String {
        var text = self
        while text.hasPrefix("@") {
            text.remove(at: text.startIndex)
        }
        return text
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    func returnOnlyNumbers() -> String {
        return String(self.filter { "0123456789".contains($0)})
    }
    
    mutating func limitSize(maxCharacteres: Int) {
        self = String(self.prefix(maxCharacteres))
    }
    
    func currencyInputFormatting() -> (value: String?, isMoreThanZero: Bool) {
        
        var number: NSNumber?
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.currencySymbol = "R$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        guard number != 0 as NSNumber else {
            return (formatter.string(from: number ?? 0), false)
        }
        
        return (formatter.string(from: number ?? 0), true)
    }
    
    func setupMoneyValue(size: Int, customColor: UIColor) -> (attributedText: NSAttributedString, stringText: String?) {
        let money = self.currencyInputFormatting()
        
        let splitedMoney = money.value?.split(separator: " ")
        let symbol = splitedMoney?.first ?? ""
        let value = splitedMoney?.last ?? ""
        
        var textColor = UIColor.picPayWhiteOff40
        if money.isMoreThanZero {
            textColor = customColor
        }
        
        let moneySymbol = NSMutableAttributedString(
            string: String(symbol),
            attributes: [NSAttributedString.Key.font: UIFont.picPayFont(with: CGFloat(size)),
                         NSAttributedString.Key.foregroundColor: textColor])
        let space = NSMutableAttributedString(string: " ")
        let moneyValue = NSMutableAttributedString(
            string: String(value),
            attributes: [NSAttributedString.Key.font: UIFont.picPayFont(with: CGFloat(size)),
                         NSAttributedString.Key.foregroundColor: textColor])
        
        moneySymbol.append(space)
        moneySymbol.append(moneyValue)
        
        return (moneySymbol, money.value)
    }
    
    func toDoubleValue() -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        let number = formatter.number(from: self)
        return number?.doubleValue
    }
}
