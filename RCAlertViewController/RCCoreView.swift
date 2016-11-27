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
    
    var rectInScreen: CGRect!
    
    var label: UILabel!
    
    var subtitle: UILabel!
    
    var path: UIBezierPath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        path = UIBezierPath()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
      //  self.setNeedsDisplay()
        
        subtitle = UILabel()
        label = UILabel()
        subtitle.sizeToFit()
    
        first = true
    }
    
   var first = true
    
    override func didMoveToWindow() {
        if self.superview != nil && !first{
        
        }
    }
    
    
    func clearButtons(){
        print("removing all..")
        self.buttons.removeAll()
    }
    
    func initTextFields(title: String, titleIsCentered: Bool, subTitle: String, subtitleIsCentered: Bool){
        // First, lets add the title
      
         let cgr = CGRect(x: 5, y: 15, width: frame.width-10, height: 30)
        label = UILabel(frame: cgr)
        label.textColor = UIColor.black
        label.font = UIFont(name: "Avenir", size: 37)
        
        label.adjustsFontSizeToFitWidth = true
        if titleIsCentered {
            label.textAlignment = .center
        }
        label.text = title
        
        
        self.addSubview(label)
        //Good, now lets add the subtitle
        
        if path != nil && label.frame.maxY != nil{
            
            let maxTitleY = label.frame.maxY
            let minLineY = path.bounds.minY
            print("MAX title Y: \(maxTitleY)")
            
            
            let font = UIFont(name: "HelveticaNeue", size: 18)!
        
            
            let height = subTitle.heightWithConstrainedWidth(width: frame.width-10, font: font)
            print("Height: \(height)")
            let subtitleCGR = CGRect(x: 5, y: maxTitleY+10, width: frame.width-10, height: height)
            subtitle = UILabel(frame: subtitleCGR)
            print(subtitleCGR)
            var labell:UILabel = UILabel(frame: subtitleCGR);
            labell.textAlignment = NSTextAlignment.left;
            if subtitleIsCentered {
                labell.textAlignment = .center
            }
            
            
           // let cgg = CGRect(x: 10, y: 100, width: 300, height: 40)
            
            labell.numberOfLines = 0;
            labell.font = UIFont.systemFont(ofSize: 16.0);
            labell.preferredMaxLayoutWidth = frame.width-10
            labell.text = subTitle;
            labell.lineBreakMode = .byWordWrapping
            labell.numberOfLines = 0;
            self.subtitle = labell
            self.addSubview(labell);
            
            let x = self.rectInScreen.minX
            let y = self.rectInScreen.minY
            let width = self.rectInScreen.width
            let newFrame = CGRect(x: x, y: y, width: width, height: subtitleCGR.maxY+80)
            super.frame = newFrame
            self.frame = newFrame
            
            
            self.setNeedsDisplay()
          
        }
        
    }
    
    
    
   
    override func draw(_ rect: CGRect) {
        print("Updating..")
        print(buttons)
        print(buttons.count)
        if path == nil {
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
        }
        
        if path.currentPoint == nil {
            path.move(to: CGPoint(x: 0, y: 0))
        }
        
        if subtitle != nil {
            print("A2")
            if subtitle.frame != nil {
                print("A3")
                if subtitle.frame.maxY != nil {
                    print("A4")
                    let maxTitleY = label.frame.maxY
                    
                    let font = UIFont(name: "HelveticaNeue", size: 18)!
                    
                    let height = subtitle.text?.heightWithConstrainedWidth(width: frame.width-10, font: font)
                    print("Height: \(height)")
                    let subtitleCGR = CGRect(x: 10, y: maxTitleY+10, width: frame.width-10, height: height!)
                    
                    print(subtitle.frame.maxY)
                    print(subtitleCGR.maxY)
                    path = UIBezierPath()
                    path.lineWidth = 2
                    
                    let bottomPointOfSubtitle: CGFloat = subtitleCGR.maxY
                    let lineY: CGFloat = bottomPointOfSubtitle + 5
                    
                    UIColor.black.setFill()
                    UIColor.black.setStroke()
                
                    path.move(to: CGPoint(x: 0, y: lineY))
                    
                    path.addLine(to: CGPoint(x: frame.maxX, y: lineY))
                    path.stroke()
                    path.fill()
                    
                    if buttons.count == 2 {
                        print("A5a")
                       print(frame.maxX)
                        print(buttons[0].frame.width)
                        let xx = buttons[0].frame.width+2.5
                        path.move(to: CGPoint(x: xx, y: lineY))
                        let p2 = CGPoint(x: xx, y: lineY+CGFloat(BUTTON_HEIGHT))
                        print(p2)
                        path.addLine(to: p2)
                        path.stroke()
                        print("A5b")
                        path.fill()
                    } else {
                        print("Button count: \(buttons.count)")
                    }
                    
                }
            }
        }
        
    }
    
    var buttons = [UIButton]()
    
    var BUTTON_HEIGHT = 70
    
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    //let handlers = [(Bool, Error?) -> Void]
    
    func addButton(title: String, type: UIButtonType ) -> UIButton{
        var button: UIButton!
        if buttons.count == 0 { // First button, bottom-left placement
            let y = self.subtitle.frame.maxY + 6
            let newY = path.currentPoint.y
            let x = 0
            let width = self.frame.width // Only one button at the moment
            let height = BUTTON_HEIGHT
            let buttonRect = CGRect(x: CGFloat(x), y: y, width: width, height: CGFloat(height))
            button = UIButton(type: type) // if you want to set the type use like UIButton(type: .RoundedRect) or UIButton(type: .Custom)
            button.setTitle(title, for: .normal)
            button.frame = buttonRect
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
//            button.buttonType = type
//            func execCompletionHandler(string: String){
//                if button != nil && button.frame != nil {
//              //  completion(true, nil)
//                }
//            }
          
        //    button.addTarget((self, action: "buttonClicked:", for: .touchUpInside)
          //  let gestureRecognizer = UITapGestureRecognizer(target: button, action:  #selector(buttonClicked(_:)))
         //   button.addGestureRecognizer(gestureRecognizer)
            print(buttonRect)
            
         //   button.backgroundColor = UIColor.brown
            self.addSubview(button)
            buttons.append(button)
            
        } else if buttons.count == 1{
            let y = self.subtitle.frame.maxY + 6
            let newY = path.currentPoint.y
            let x = 5
            let width = self.frame.width / 2 - 7// Two buttons now
            let height = BUTTON_HEIGHT
            let buttonRect = CGRect(x: CGFloat(x), y: y, width: width+8, height: CGFloat(height))
           
            buttons[0].frame = buttonRect
           let button2Rect = CGRect(x: CGFloat(buttonRect.width+7), y: y, width: width-10, height: CGFloat(height))
            
            buttons[0] = UIButton(frame: buttonRect)
            button = UIButton(type: type) // if you want to set the type use like UIButton(type: .RoundedRect) or UIButton(type: .Custom)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.frame = button2Rect
         //   button.layer.borderWidth = 2
            //            button.buttonType = type
            //            func execCompletionHandler(string: String){
            //                if button != nil && button.frame != nil {
            //              //  completion(true, nil)
            //                }
            //            }
            
            //    button.addTarget((self, action: "buttonClicked:", for: .touchUpInside)
            //  let gestureRecognizer = UITapGestureRecognizer(target: button, action:  #selector(buttonClicked(_:)))
            //   button.addGestureRecognizer(gestureRecognizer)
         //   print(buttonRect)
          //  button.backgroundColor = UIColor.cyan
            self.addSubview(button)
            
            buttons.append(button)
          //  self.setNeedsDisplay()
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            
            
        }
        
        self.setNeedsDisplay()
        
        
        print("Real button count: \(buttons.count)")
        
        return button
    }
    
    func buttonClicked(_ sender: AnyObject?) {
        var slot = 0
        
//        for button in buttons {
//            if buttons[slot] == sender as! UIButton{
//                // Exec
//                
//            } else {
//                slot = slot + 1;
//            }
//            
//        }
    }
    
    func addTitle(title: String, centered: Bool) {
        print("Title should be added..")
        let cgr = CGRect(x: 5, y: 15, width: frame.width-10, height: 30)
        print("Title CGRect: \(cgr)")
        label = UILabel(frame: cgr)
        label.textColor = UIColor.black
        //rcAC.display()
        label.font = UIFont(name: "Avenir", size: 37)
        
        label.adjustsFontSizeToFitWidth = true
        if centered {
            label.textAlignment = .center
        }
        label.text = title
        
        
        self.addSubview(label)
        
        
        
    }
    
    func addSubtitle(title: String, centered: Bool) {
        print("Subtitle should be added..")
        if path != nil && label.frame.maxY != nil{
            let maxTitleY = label.frame.maxY
            
            let minLineY = path.bounds.minY
            let subtitleCGR = CGRect(x: 5, y: maxTitleY+10, width: frame.width-10, height: 20)
            //print("Subtitle CGRect: \(subtitleCGR)")
            //     subtitle.lineBreakMode =
            subtitle = UILabel(frame: subtitleCGR)
            subtitle.textColor = UIColor.black
            //rcAC.display()
            subtitle.font = UIFont(name: "Avenir", size: 18)
            
            subtitle.numberOfLines = 0
            //  label.adjustsFontSizeToFitWidth = true
            if centered {
                subtitle.textAlignment = .center
            }
            subtitle.text = title
            
            subtitle.preferredMaxLayoutWidth = frame.width - 10
            subtitle.numberOfLines = 0;
            subtitle.lineBreakMode = .byCharWrapping
            
            self.addSubview(subtitle)
        }
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
extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
