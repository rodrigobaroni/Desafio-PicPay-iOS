//
//  MainCoordinator.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 09/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ContactListViewController.instantiate()
        vc.coordinator = self
        setToUseLargeTitle(true)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func addNewCard() {
        let vc = AddNewCardViewController.instantiate()
        vc.coordinator = self
        setToUseLargeTitle()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCard() {
        let vc = CardViewController.instantiate()
        vc.coordinator = self
        setToUseLargeTitle()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func inputValue() {
        let vc = InputValueViewController.instantiate()
        vc.coordinator = self
        setToUseLargeTitle()
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func setToUseLargeTitle(_ show: Bool = false) {
        if #available(iOS 11.0, *) {
            self.navigationController.navigationBar.prefersLargeTitles = show
        }
    }
}
