//
//  DataResquest+Extension.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 08/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            do {
                let model = try newJSONDecoder().decode(T.self, from: data)
                return Result.success(model)
            } catch {
                return Result.failure(error)
            }
        }
    }
    
    @discardableResult func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult func responseUser(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<User>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
    @discardableResult func responsePaymentModel(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<PaymentModel>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
