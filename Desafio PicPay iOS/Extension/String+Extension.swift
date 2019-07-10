//
//  String+Extension.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 09/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

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
}
