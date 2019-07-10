//
//  DataStorage.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 09/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

private struct Key {
    static let cardNumber = "cardNumber"
    static let cardCVV = "cardCVV"
    static let cardDate = "cardExpiryDate"
    static let cardName = "cardName"
}

class DataStorage {
    
    static func saveCardWith(data: CardModel?, completion: @escaping(_ sucess: Bool) -> Void) {
        if let card = data,
            let name = card.cardName,
            let cvv = card.cvv,
            let date = card.expiryDate,
            let number = card.cardNumber {
            
            let savedName = KeychainWrapper.standard.set(name, forKey: Key.cardName)
            let savedCvv = KeychainWrapper.standard.set(cvv, forKey: Key.cardCVV)
            let savedDate = KeychainWrapper.standard.set(date, forKey: Key.cardDate)
            let savedNumber = KeychainWrapper.standard.set(number, forKey: Key.cardNumber)
            if savedName && savedCvv && savedDate && savedNumber {
                completion(true)
                return
            }
        }
        completion(false)
    }
    
    static func retriveCardSaved(completion: @escaping(_ card: CardModel?) -> Void) {
        let savedName = KeychainWrapper.standard.string(forKey: Key.cardName)
        let savedCvv = KeychainWrapper.standard.integer(forKey: Key.cardCVV)
        let savedDate = KeychainWrapper.standard.string(forKey: Key.cardDate)
        let savedNumber = KeychainWrapper.standard.string(forKey: Key.cardNumber)
        
        if let cardNumber = savedNumber,
            let cardName = savedName,
            let cardCVV = savedCvv,
            let cardDate = savedDate {
            let card = CardModel(cardNumber: cardNumber, cvv: cardCVV, cardName: cardName, expiryDate: cardDate)
            
            completion(card)
            return
        }
        completion(nil)
    }
}

