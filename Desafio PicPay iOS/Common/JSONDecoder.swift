//
//  JSONDecoder.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 08/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
