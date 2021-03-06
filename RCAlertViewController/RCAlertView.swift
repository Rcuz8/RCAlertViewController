//
//  RCAlertView.swift
//  RCAlertViewController
//
//  Created by Ryan Cocuzzo on 11/26/16.
//  Copyright © 2016 rcocuzzo8. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class RCAlertView: UIViewController {
    
    var rcView: RCCoreView!
    
    var blurView: UIVisualEffectView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.clear
        self.modalPresentationStyle = .overCurrentContext
        let blur = UIBlurEffect(style: .dark)
        blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.8
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        
        rcView = RCCoreView()
        rcView.adjustCornerRadius(to: 5)
        rcView.adjustBackgroundColor(to: UIColor.white)
        rcView.adjustBorderColor(to: UIColor.black)
        rcView.adjustBorderWidth(to: 4)
        adjustDimensions(width: 270, height: 144) //Default Notification Size
        
        self.view.addSubview(rcView)
   
    }
    
    
    func addLongPressRecognizer(){
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(dismissMe))
        longPressRecognizer.minimumPressDuration = 1.5
        self.blurView.addGestureRecognizer(longPressRecognizer)
    }
    
    func addLongPressRecognizer(minimumDuration: Float){
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(dismissMe))
        longPressRecognizer.minimumPressDuration = CFTimeInterval(minimumDuration)
        self.blurView.addGestureRecognizer(longPressRecognizer)
    }
    
    
    func addTapPressRecognizer(){
        let tapPressRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMe))
        self.blurView.addGestureRecognizer(tapPressRecognizer)
    }
    
    func dismissMe(){
        rcView.clearButtons()
        navigationController?.popViewController(animated: true)
        dismiss(animated: false, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTitle(title: String, centered: Bool) {
        self.rcView.addTitle(title: title, centered: centered)
    }
    
    func addSubtitle(title: String, centered: Bool) {
        self.rcView.addSubtitle(title: title, centered: centered)
    }
    
    func initTextFields(title: String, titleIsCentered: Bool, subTitle: String, subtitleIsCentered: Bool){

     self.rcView.initTextFields(title: title, titleIsCentered: titleIsCentered, subTitle: subTitle, subtitleIsCentered: subtitleIsCentered)
    }
    
    typealias CompletionHandler = (_ buttonIsActive:Bool) -> Void
    
    
    func addButton(title: String, type: UIButtonType)-> UIButton {
        let button = rcView.addButton(title: title, type: type)
        rcView.setNeedsDisplay()
       
        return button
    }
    
    func adjustDimensions(width: Float, height: Float){
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        if width < Float(screenWidth) && height < Float(screenHeight){
            
            let margin = (Float(screenWidth) - width) / 2
            
            let marginH = (Float(screenHeight) - height) / 2
            
            print("Creating frame:\nx: \(CGFloat(margin))\ny: \(CGFloat(marginH))\nwidth: \(CGFloat(width))\nheight: \(CGFloat(height))")
            rcView.frame = CGRect(x:  CGFloat(margin), y: CGFloat(marginH), width: CGFloat(width), height: CGFloat(height))
            rcView.rectInScreen = CGRect(x:  CGFloat(margin), y: CGFloat(marginH), width: CGFloat(width), height: CGFloat(height))
        } else {
            rcView.frame = CGRect(x:  0, y: 0, width: screenWidth, height: screenHeight)
            rcView.rectInScreen = CGRect(x:  0, y: 0, width: screenWidth, height: screenHeight)
        }
        
    }
    
    func adjustToFilledViewWithMargins(horizontalMargin: Float, verticalMargin: Float) {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        if horizontalMargin < Float(screenWidth/2) && verticalMargin < Float(screenHeight/2) {
            let width = Float(screenWidth) - (horizontalMargin*2)
            let height = Float(screenHeight) - (verticalMargin*2)
            rcView.frame = CGRect(x:  CGFloat(horizontalMargin), y: CGFloat(verticalMargin), width: CGFloat(width), height: CGFloat(height))
            
        } else {
            rcView.frame = CGRect(x:  0, y: 0, width: screenWidth, height: screenHeight)
        }
    }
    
    
    func changeColor(to: UIColor){
        rcView.backgroundColor = to
    }
    
    func display() {
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController?.present(self, animated: false, completion: nil)
    }
    
}
