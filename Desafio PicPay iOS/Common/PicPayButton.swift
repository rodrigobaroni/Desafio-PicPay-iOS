//
//  PicPayButton.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 05/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class PicPayButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupButton()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupButton()
    }
    
    private func setupButton() {
        let half = 0.5
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor.picPayGreen
        self.layer.cornerRadius = CGFloat(half) * bounds.size.height
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
    }
    
    override public var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = UIColor.picPayGreen
                return
            }
            self.backgroundColor = UIColor.picPayWhiteOff60
        }
    }
    
}
