//
//  InputValueViewController.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 04/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

class InputValueViewController: UIViewController, Storyboarded {

    @IBOutlet private(set) weak var userImageView: UIImageView?
    @IBOutlet private(set) weak var userNickNameLabel: UILabel?
    @IBOutlet private(set) weak var valueTextField: UITextField?
    @IBOutlet private(set) weak var cardNameLabel: UILabel?
    @IBOutlet private(set) weak var paymentButton: PicPayButton?
    @IBOutlet private weak var paymentButtonConstraint: NSLayoutConstraint?
    
    weak var coordinator: MainCoordinator?
    var user: UserModel?
    var card: CardModel?
    var value: Double?
    
    private var bottomConstraintPaymentButtonNormal = CGFloat(16)
    private var keyboardHeight: CGFloat? {
        didSet {
            UIView.animate(withDuration: 0.25, animations: {
                let keyboardHeight = self.keyboardHeight ?? 0
                let result = keyboardHeight + self.bottomConstraintPaymentButtonNormal
                self.paymentButtonConstraint?.constant = result
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextField()
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.valueTextField?.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let rect = keyboardSize.cgRectValue
            self.keyboardHeight = rect.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardHeight = 0
    }
    
    private func setupTextField() {
        self.valueTextField?.addTarget(self, action: #selector(moneyTextFieldDidChange), for: .editingChanged)
        self.valueTextField?.becomeFirstResponder()
    }
    
    private func setupLayout() {
        guard let user = user,
            let card = card else {
            return
        }
        self.userNickNameLabel?.text = user.username
        self.userImageView?.downloaded(from: user.img ?? "")
        self.userImageView?.setRounded()
        self.userImageView?.clipsToBounds = true
        self.userImageView?.setNeedsDisplay()
        let cardNumber = card.cardNumber?.suffix(4) ?? ""
        if let cardType = card.cardType {
            self.cardNameLabel?.text = cardType + " final " + cardNumber
            return
        }
        self.cardNameLabel?.text = "Cartão final " + cardNumber
    }
    
    @objc func moneyTextFieldDidChange(_ textField: UITextField) {
        if let amountString = self.valueTextField?.text?.setupMoneyValue(size: 54, customColor: .picPayGreen) {
            self.value = amountString.stringText?.toDoubleValue()
            self.valueTextField?.attributedText = amountString.attributedText
        }
    }
    
    private func createTransactionModel() -> TransactionParameters {
        let transactionParameters = TransactionParameters(cardNumber: card?.cardNumber,
                                                          cvv: card?.cvv,
                                                          value: self.value,
                                                          expiryDate: card?.expiryDate,
                                                          destination: user?.id)
        return transactionParameters
        
    }
    
    private func callService() {
        let parameters = createTransactionModel()
        Service.payment(body: parameters) { [weak self] (paymentModel) in
            if let payment = paymentModel {
                self?.coordinator?.detailPayment(details: payment)
            }
            self?.showAlert()
        }
    }
    
    @IBAction func paymentAction(_ sender: Any) {
        self.callService()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "PicPay", message: "Não foi possível pagar no momento", preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Tentar de novo", style: .default) { [weak self] action in
            self?.callService()
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(tryAgain)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editCardAction(_ sender: Any) {
        
        //TODO: editar cartão
    }

}
