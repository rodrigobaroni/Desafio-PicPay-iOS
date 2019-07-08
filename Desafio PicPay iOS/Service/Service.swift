//
//  Service.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 08/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    func users(method: HTTPMethod, url: ServiceURLRequest,completion : @escaping () -> Void)
    func payment(method: HTTPMethod, url: ServiceURLRequest, body: String,completion : @escaping () -> Void)
}

class Service: ServiceProtocol {
    
    func users(method: HTTPMethod, url: ServiceURLRequest, completion: @escaping () -> Void) {
        
    }
    
    func payment(method: HTTPMethod, url: ServiceURLRequest, body: String, completion: @escaping () -> Void) {
        
    }
    
    func sendRequestRequest() {
        /**
         Request
         get http://careers.picpay.com/tests/mobdev/users
         */
        
        // Fetch Request
        Alamofire.request("http://careers.picpay.com/tests/mobdev/users", method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    }

}

struct ServiceURLRequest {
    static let users = "http://careers.picpay.com/tests/mobdev/users"
    static let payment = "http://careers.picpay.com/tests/mobdev/transaction"
    
}
