//
//  MainCoordinator.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 09/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = ContactListViewController.instantiate()
        vc.coordinator = self
        self.setToUseLargeTitle(true)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func addNewCard(user: UserModel?) {
        let vc = AddNewCardViewController.instantiate()
        vc.coordinator = self
        vc.user = user
        self.setToUseLargeTitle()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCard(user: UserModel?, card: CardModel?) {
        let vc = CardViewController.instantiate()
        vc.coordinator = self
        vc.user = user
        vc.cardModel = card
        self.setToUseLargeTitle()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func inputValue(user: UserModel?, card: CardModel?) {
        let vc = InputValueViewController.instantiate()
        vc.coordinator = self
        vc.user = user
        vc.card = card
        self.setToUseLargeTitle()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func detailPayment(details: PaymentModel?) {
        let vc = DetailViewController.instantiate()
        vc.coordinator = self
        vc.details = details
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.setToUseLargeTitle()
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            if let addCardViewController = fromViewController as? CardViewController {
                childDidFinish(addCardViewController.coordinator)
            }
            if let inputValueViewController = fromViewController as? InputValueViewController {
                childDidFinish(inputValueViewController.coordinator)
            }
            return
        }
        
    }
    
}
