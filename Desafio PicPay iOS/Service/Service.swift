//
//  Service.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 08/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import Alamofire

private struct ServiceURLRequest {
    static let users = "http://careers.picpay.com/tests/mobdev/users"
    static let payment = "http://careers.picpay.com/tests/mobdev/transaction"
}

class Service {
    
    static func users(completion: @escaping (_ response: User?) -> Void) {
        Alamofire.request(ServiceURLRequest.users, method: .get)
            .validate(statusCode: 200..<300).responseUser(completionHandler: { (response) in
                if let userModel = response.result.value {
                    completion(userModel)
                }
                completion(nil)
            })
        completion(nil)
    }
    
    static func payment(body: TransactionParameters?, completion: @escaping (_ response: PaymentModel?) -> Void) {
        guard let parameters = body else {
            completion(nil)
            return
        }
        let bodyParameters = parameters.dictionaryRepresentation
        Alamofire.request(ServiceURLRequest.payment, method: .post, parameters: bodyParameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                do {
                    let model = try newJSONDecoder().decode(PaymentModel.self, from: data)
                    completion(model)
                } catch {
                    completion(nil)
                }
        }
    }
}
