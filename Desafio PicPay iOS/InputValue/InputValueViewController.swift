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
    
    private var bottomConstraintPaymentButtonNormal = CGFloat(16)
    private var sizeOfImageView = CGFloat(40)
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
        self.setNotification()
        self.valueTextField?.becomeFirstResponder()
        self.setupLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
    
    private func setupLayout() {
        guard let user = user,
            let card = card else {
            return
        }
        self.userNickNameLabel?.text = user.username
        self.userImageView?.downloaded(from: user.img ?? "")
        let cardName = card.cardName ?? ""
        let cardNumber = card.cardNumber?.suffix(4) ?? ""
        self.cardNameLabel?.text = cardName + " " + cardNumber
        self.userImageView?.layer.cornerRadius = ((self.userImageView?.frame.size.width ?? sizeOfImageView) / 2)
        self.userImageView?.clipsToBounds = true
        self.userImageView?.setNeedsDisplay()
    }

}
