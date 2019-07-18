//
//  CardModel.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 09/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

struct CardModel {
    let cardNumber: String?
    let cvv: Int?
    let cardName: String?
    let expiryDate: String?
    let cardType: String?
    
    init(cardNumber: String, cvv: Int, cardName: String, expiryDate: String, cardType: String?) {
        self.cardNumber = cardNumber
        self.cvv = cvv
        self.cardName = cardName
        self.expiryDate = expiryDate
        self.cardType = cardType
    }
    
}
