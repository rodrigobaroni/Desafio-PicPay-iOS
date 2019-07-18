//
//  UIFont+Extension.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 17/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func picPayFont(with size: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue", size: size) {
            return font
        }
        return UIFont()
    }
    
    
}

