//
//  AppDelegate.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 04/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navController = self.setupNavigationController()
        
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        self.setupKeyboard()
        
        
        return true
    }
    
    
    private func setupNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.picPayWhite]
        if #available(iOS 11.0, *) {
            navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.picPayWhite]
        }
        navController.navigationBar.tintColor = UIColor.picPayGreen
        navController.navigationBar.barTintColor = UIColor.picPayBlack
        
        return navController
    }
    
    private func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100.0
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}

