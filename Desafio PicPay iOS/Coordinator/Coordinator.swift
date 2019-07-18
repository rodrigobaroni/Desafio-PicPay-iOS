//
//  Coordinator.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 09/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    func setToUseLargeTitle(_ show: Bool = false) {
        if #available(iOS 11.0, *) {
            self.navigationController.navigationBar.prefersLargeTitles = show
        }
    }
}
