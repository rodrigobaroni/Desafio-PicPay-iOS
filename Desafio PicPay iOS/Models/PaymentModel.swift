//
//  PaymentModel.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 08/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

struct PaymentModel: Codable {
    let transaction: Transaction?
}

struct Transaction: Codable {
    let id, timestamp: Int?
    let value: Double?
    let destinationUser: UserModel?
    let success: Bool?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id, timestamp, value
        case destinationUser = "destination_user"
        case success, status
    }
}

