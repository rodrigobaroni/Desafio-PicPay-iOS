//
//  CardViewController.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 04/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CardViewController: CustomViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    
    private var isKeyboardUp: Bool = false
    private var normalConstraint = CGFloat(16)
    var cardModel: CardModel?
    var isSaveButtonEnable: Bool = false {
        didSet {
            isSaveButtonEnable = allTextFieldsAreFilled()
            self.saveCardButton?.isHidden = !isSaveButtonEnable
        }
    }
    
    @IBOutlet private (set) weak var cardNumberTextField: SkyFloatingLabelTextField?
    @IBOutlet private (set) weak var cardNameTextField: SkyFloatingLabelTextField?
    @IBOutlet private (set) weak var cardExpiryDateTextField: SkyFloatingLabelTextField?
    @IBOutlet private (set) weak var cardCVVTextField: SkyFloatingLabelTextField?
    @IBOutlet private (set) weak var saveCardButton: PicPayButton?
    @IBOutlet private (set) weak var saveButtonBottomConstraint: NSLayoutConstraint?
    @IBOutlet private (set) weak var saveButtonUpConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()
        self.saveCardButton?.isHidden = !isSaveButtonEnable
        
        //TODO: Handler keyboard height
    }

    private func setupTextFields() {
        self.cardNumberTextField?.delegate = self
        self.cardNameTextField?.delegate = self
        self.cardExpiryDateTextField?.delegate = self
        self.cardCVVTextField?.delegate = self
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
        if let cardName = self.cardNameTextField?.text,
            let cardNumber = self.cardNumberTextField?.text,
            let cvv = Int(self.cardCVVTextField?.text ?? ""),
            let date = self.cardExpiryDateTextField?.text {
            
            self.cardModel = CardModel(cardNumber: cardNumber, cvv: cvv, cardName: cardName, expiryDate: date)
        }
    }
    
    @IBAction func saveCardAction(_ sender: Any) {
        self.createCardModel()
        DataStorage.saveCardWith(data: self.cardModel) { [weak self] sucess in
            if sucess {
                self?.coordinator?.inputValue()
            }
            print(sucess)
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
