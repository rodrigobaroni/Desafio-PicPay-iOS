//
//  PaymentModel.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 08/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import Alamofire

struct PaymentModel: Codable {
    let transaction: Transaction?
}

extension PaymentModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PaymentModel.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        transaction: Transaction?? = nil
        ) -> PaymentModel {
        return PaymentModel(
            transaction: transaction ?? self.transaction
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

struct Transaction: Codable {
    let id, timestamp: Int?
    let value: String?
    let destinationUser: DestinationUser?
    let success: Bool?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id, timestamp, value
        case destinationUser = "destination_user"
        case success, status
    }
}

extension Transaction {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Transaction.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: Int?? = nil,
        timestamp: Int?? = nil,
        value: String?? = nil,
        destinationUser: DestinationUser?? = nil,
        success: Bool?? = nil,
        status: String?? = nil
        ) -> Transaction {
        return Transaction(
            id: id ?? self.id,
            timestamp: timestamp ?? self.timestamp,
            value: value ?? self.value,
            destinationUser: destinationUser ?? self.destinationUser,
            success: success ?? self.success,
            status: status ?? self.status
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// DestinationUser.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let destinationUser = try DestinationUser(json)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDestinationUser { response in
//     if let destinationUser = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - DestinationUser
struct DestinationUser: Codable {
    let id: Int?
    let name: String?
    let img: String?
    let username: String?
}

// MARK: DestinationUser convenience initializers and mutators

extension DestinationUser {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DestinationUser.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        id: Int?? = nil,
        name: String?? = nil,
        img: String?? = nil,
        username: String?? = nil
        ) -> DestinationUser {
        return DestinationUser(
            id: id ?? self.id,
            name: name ?? self.name,
            img: img ?? self.img,
            username: username ?? self.username
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


