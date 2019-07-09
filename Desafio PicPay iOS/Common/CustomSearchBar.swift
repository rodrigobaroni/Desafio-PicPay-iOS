//
//  CustomSearchBar.swift
//  CustomSearchBar
//
//  Created by Gabriel Theodoropoulos on 8/9/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    override func draw(_ rect: CGRect) {
        
        if let index = indexOfSearchFieldInSubviews() {
            
            let searchField: UITextField = (subviews[0] ).subviews[index] as? UITextField ?? UITextField()
            
            searchField.frame = CGRect(x: 5.0, y: 5.0, width: frame.size.width - 10.0, height: frame.size.height - 10.0)
            searchField.font = UIFont(name: "HelveticaNeue", size: CGFloat(15))
            searchField.textColor = UIColor.picPayWhite
            
            searchField.backgroundColor = UIColor.picPayBlack
        }
        
        let startPoint = CGPoint(x: 0.0, y: frame.size.height)
        let endPoint = CGPoint(x: frame.size.width, y: frame.size.height)
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 2.5
        
        layer.addSublayer(shapeLayer)
        
        super.draw(rect)
    }
    

    
    init(frame: CGRect, font: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        
        searchBarStyle = UISearchBar.Style.default
        isTranslucent = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func indexOfSearchFieldInSubviews() -> Int! {
        
        var index: Int!
        let searchBarView = subviews[0] 
        for i in 0..<searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UITextField.self) {
                index = i
                break
            }
        }
        return index
    }
}
