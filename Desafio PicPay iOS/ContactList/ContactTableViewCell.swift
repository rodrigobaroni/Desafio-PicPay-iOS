//
//  ContactTableViewCell.swift
//  Desafio PicPay iOS
//
//  Created by Rodrigo Alexis Garcia Baroni on 04/07/2019.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet private(set) weak var nickNameLabel: UILabel?
    @IBOutlet private(set) weak var nameLabel: UILabel?
    @IBOutlet private(set) weak var userImgView: UIImageView?
    
    private let sizeOfImageView = CGFloat(52)
    
    var contact: UserModel? {
        didSet {
            self.setupContact()
            self.setupCell()
        }
    }
    
    func setupCell() {
        self.backgroundColor = UIColor.picPayBlack
    }
    
    func setupContact() {
        
        if let contact = contact, let name = contact.name, let nickName = contact.username, let image = contact.img {
            self.nickNameLabel?.text = nickName
            self.nameLabel?.text = name
            self.userImgView?.downloaded(from: image)
            self.userImgView?.layer.cornerRadius = ((self.userImgView?.frame.size.width ?? sizeOfImageView) / 2)
            self.userImgView?.clipsToBounds = true
            self.setNeedsDisplay()
        }
    }
    
}
