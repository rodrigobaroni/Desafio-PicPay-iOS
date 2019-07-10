//
//  AddNewCardViewController.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 04/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

class AddNewCardViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNewCardAction(_ sender: Any) {
        coordinator?.showCard(user: self.user)
    }

}
