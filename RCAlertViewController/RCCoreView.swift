//
//  RCCoreView.swift
//  RCAlertViewController
//
//  Created by Ryan Cocuzzo on 11/26/16.
//  Copyright © 2016 rcocuzzo8. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class RCCoreView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func adjustBorderWidth(to: Int) {
        self.layer.borderWidth = CGFloat(to)
    }
    
    func adjustBorderColor(to: UIColor){
        self.layer.borderColor = to.cgColor
    }
    
    func adjustCornerRadius(to: Int){
        self.layer.cornerRadius = CGFloat(to)
    }
    
    func adjustBackgroundColor(to: UIColor){
        self.backgroundColor = to
    }
}
