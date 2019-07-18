//
//  DetailViewController.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 04/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

class DetailViewController: ViewControllerPannable, Storyboarded {

    @IBOutlet private(set) weak var userImageView: UIImageView?
    @IBOutlet private(set) weak var nickNameLabel: UILabel?
    @IBOutlet private(set) weak var dateLabel: UILabel?
    @IBOutlet private(set) weak var transactionLabel: UILabel?
    @IBOutlet private(set) weak var cardNameLabel: UILabel?
    @IBOutlet private(set) weak var valueLabel: UILabel?
    @IBOutlet private(set) weak var totalTextLabel: UILabel?
    @IBOutlet private(set) weak var totalValueLabel: UILabel?
    
    
    weak var coordinator: MainCoordinator?
    var details: PaymentModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }
    
    private func setupLayout() {

        if let _ = details,
            let transaction = details?.transaction,
            let user = transaction.destinationUser {
            self.userImageView?.downloaded(from: user.img ?? "")
            self.userImageView?.setRounded()
            self.nickNameLabel?.text = user.username
            self.dateLabel?.text = getDateFromTimeStamp(timeStamp: transaction.timestamp ?? 0)
            self.transactionLabel?.text = "Transação: " + String(transaction.id ?? 0)
            self.cardNameLabel?.text = "Cartão Master 1234"
            let value = String(transaction.value ?? 0)
            let stringValue = value.currencyInputFormatting().value
            self.valueLabel?.text = stringValue
            self.totalValueLabel?.text = stringValue
            
        }
    }

    private func getDateFromTimeStamp(timeStamp: Int) -> String {
        
        let date = NSDate(timeIntervalSince1970: Double(timeStamp))
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd/MM/YYYY 'às' hh:mm"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
}
