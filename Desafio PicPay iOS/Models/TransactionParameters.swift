//
//  TransactionParameters.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 08/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import UIKit

struct TransactionParameters: Codable {
    
    var cardNumber: String?
    var cvv: Int?
    var value: Double?
    var expiryDate: String?
    var destinationUserID: Int?
    
    init(cardNumber: String?, cvv: Int?, value: Double?, expiryDate: String?, destination: Int?) {
        self.cardNumber = cardNumber
        self.cvv = cvv
        self.value = value
        self.expiryDate = expiryDate
        self.destinationUserID = destination
    }
    
    var dictionaryRepresentation: [String: Any] {
        guard let cardNumber = cardNumber,
            let value = value,
            let destination = destinationUserID,
            let cvv = cvv,
            let expiryDate = expiryDate else {
                return [String(): (Any).self]
        }
        
        return [
            "card_number" : cardNumber,
            "value" : value,
            "destination_user_id" : destination,
            "cvv" : cvv,
            "expiry_date" : expiryDate
        ]
    }
}

