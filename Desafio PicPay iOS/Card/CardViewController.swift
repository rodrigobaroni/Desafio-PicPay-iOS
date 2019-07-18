//
//  CardViewController.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 04/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import CreditCardValidator

class CardViewController: CustomViewController, Storyboarded {
    
    @IBOutlet private (set) weak var cardNumberTextField: SkyFloatingLabelTextField?
    @IBOutlet private (set) weak var cardNameTextField: SkyFloatingLabelTextField?
    @IBOutlet private (set) weak var cardExpiryDateTextField: SkyFloatingLabelTextField?
    @IBOutlet private (set) weak var cardCVVTextField: SkyFloatingLabelTextField?
    @IBOutlet private (set) weak var saveCardButton: PicPayButton?
    @IBOutlet private (set) weak var saveButtonBottomConstraint: NSLayoutConstraint?
    @IBOutlet private (set) weak var saveButtonUpConstraint: NSLayoutConstraint?
    
    weak var coordinator: MainCoordinator?
    
    private var isKeyboardUp: Bool = false
    private var normalConstraint = CGFloat(16)
    var isEditingCard: Bool = false
    var cardModel: CardModel?
    var user: UserModel?
    
    var isSaveButtonEnable: Bool = false {
        didSet {
            isSaveButtonEnable = allTextFieldsAreFilled()
            self.saveCardButton?.isHidden = !isSaveButtonEnable
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()
        self.fillAllTextfield()
        self.saveCardButton?.isHidden = !isSaveButtonEnable
    }

    private func setupTextFields() {
        self.cardNumberTextField?.delegate = self
        self.cardNameTextField?.delegate = self
        self.cardExpiryDateTextField?.delegate = self
        self.cardCVVTextField?.delegate = self
    }
    
    private func fillAllTextfield() {
        if let card = cardModel,
            let name = card.cardName,
            let number = card.cardNumber,
            let expiryDate = card.expiryDate,
            let cvv = card.cvv {
                isEditingCard = true
                isSaveButtonEnable = true
                self.cardNumberTextField?.text = number
                self.cardNameTextField?.text = name
                self.cardExpiryDateTextField?.text = expiryDate
                self.cardCVVTextField?.text = "\(cvv)"
            return
        }
        isEditingCard = false
    }
    
    private func allTextFieldsAreFilled() -> Bool {
        if let isNameEmpty = self.cardNameTextField?.text?.isEmpty,
            let isNumberValid = self.cardNumberTextField?.text?.isValidCreditCard(),
            let isCVVEmpty = self.cardCVVTextField?.text?.isEmpty,
            let isExpiryDateEmpty = self.cardExpiryDateTextField?.text?.isEmpty {
            
            if isNameEmpty || !isNumberValid || isCVVEmpty || isExpiryDateEmpty {
                return false
            }
            return true
        }
        return false
    }
    
    func createCardModel() {
        let cardType = CreditCardValidator()

        if let cardName = self.cardNameTextField?.text,
            let cardNumber = self.cardNumberTextField?.text,
            let cvv = Int(self.cardCVVTextField?.text ?? ""),
            let date = self.cardExpiryDateTextField?.text {
        
            if let flagCard = cardType.type(from: cardNumber) {
                self.cardModel = CardModel(cardNumber: cardNumber, cvv: cvv, cardName: cardName, expiryDate: date, cardType: flagCard.name)
                return
            }
            self.cardModel = CardModel(cardNumber: cardNumber, cvv: cvv, cardName: cardName, expiryDate: date, cardType: nil)
        }
    }
    
    @IBAction func saveCardAction(_ sender: Any) {
        self.createCardModel()
        DataStorage.saveCardWith(data: self.cardModel) { [weak self] sucess in
            if sucess {
                self?.coordinator?.inputValue(user: self?.user, card: self?.cardModel)
            }
        }
    }
}

extension CardViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case self.cardNumberTextField:
            self.cardNumberTextField?.text = textField.text?.creditCardNumberMask()
        case self.cardExpiryDateTextField:
            self.cardExpiryDateTextField?.text = textField.text?.cardDateMask()
        default:
            break
        }
        self.isSaveButtonEnable = allTextFieldsAreFilled()
        return true
    }
    
}
