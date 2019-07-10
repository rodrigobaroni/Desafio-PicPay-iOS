//
//  String+Mask.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 09/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func removeMask() -> String {
        var textWithouMask = self.replacingOccurrences(of: "-", with: "")
        textWithouMask = textWithouMask.replacingOccurrences(of: ".", with: "")
        textWithouMask = textWithouMask.replacingOccurrences(of: "/", with: "")
        textWithouMask = textWithouMask.replacingOccurrences(of: "(", with: "")
        textWithouMask = textWithouMask.replacingOccurrences(of: ")", with: "")
        textWithouMask = textWithouMask.replacingOccurrences(of: " ", with: "")
        textWithouMask = textWithouMask.replacingOccurrences(of: " ", with: "")
        textWithouMask = textWithouMask.trim()
        return textWithouMask
    }
    
    func creditCardNumberMask() -> String {
        var newString = self.returnOnlyNumbers()
        var forAux = newString.count
        var i = 0
        while i < forAux {
            let index = newString.index(newString.startIndex, offsetBy: i)
            if (i == 4 || i == 9 || i == 14) && newString[index] != " " {
                newString.insert(" ", at: index)
                forAux = forAux + 1
            }
            i = i + 1
        }
        
        newString.limitSize(maxCharacteres: 21)
        return newString
    }
    
    func isValidCreditCard() -> Bool {
        let newString = self.removeMask()
        if newString.count > 15 {
            return true
        }
        return false
    }
    
    func cardDateMask() -> String {
        var newString = self.returnOnlyNumbers()
        if newString.prefix(1) != "0" && newString.prefix(1) != "1" && newString.prefix(1) != "" {
            newString.insert("0", at: newString.startIndex)
        }
        if newString.count > 1 {
            let secondChar = newString[index(startIndex, offsetBy: 1)]
            if newString.prefix(1) == "0" &&  (Int(String(secondChar)) ?? 9) == 0 {
                newString.remove(at: newString.index(newString.startIndex, offsetBy: 1))
            }
            if newString.prefix(1) == "1" && ((Int(String(secondChar)) ?? 0) > 2) {
                newString.remove(at: newString.index(newString.startIndex, offsetBy: 1))
            }
        }
        for i in 0 ..< newString.count {
            let index = newString.index(newString.startIndex, offsetBy: i)
            if i == 2 && newString[index] != "/" {
                newString.insert("/", at: index)
            }
        }
        newString.limitSize(maxCharacteres: 5)
        return newString
    }
}
