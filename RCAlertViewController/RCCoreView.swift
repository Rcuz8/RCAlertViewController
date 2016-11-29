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
            super.center = CGPoint.Center
            self.center = CGPoint.Center
            
            
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
            //  button.backgroundColor = UIColor.cyan
            self.addSubview(button)
            buttons.append(button)
            
        } else if buttons.count > 1 {
            
            // Init button
            let y = self.subtitle.frame.maxY + 6
            button = UIButton(type: type)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            let lastButtonY = CGFloat(BUTTON_HEIGHT*buttons.count)
            button.frame = CGRect(x: CGFloat(0), y: (y+(lastButtonY)), width: super.frame.width, height: CGFloat(BUTTON_HEIGHT))
            buttons.append(button)
            self.addSubview(button)
            
            print("INFORMATION OF BUTTONS CURRENTLY:\n\nCurrent amount of buttons: \(buttons.count)")
            for button in buttons {
            print("Button Info: \nFrame: \(button.frame)\nTitle:\(button.titleLabel?.text)\n")
            }
            
            var buttonNum = 0
            for button in buttons {
                let by = CGFloat(BUTTON_HEIGHT*buttonNum)
                button.frame = CGRect(x: CGFloat(0), y: y + by, width: super.frame.width, height: CGFloat(BUTTON_HEIGHT))
                buttonNum = buttonNum + 1
            }
            
            // Re-initialize frame of view with new dimensions
            let lb = buttons[buttons.count-1] as! UIButton
            let lby = lb.frame.maxY
            let lastY = lby //+ CGFloat(BUTTON_HEIGHT)
            // Init main frame
            let ox = self.rectInScreen.minX
            let oy = self.rectInScreen.minY
            let owidth = self.rectInScreen.width
            let newFrame = CGRect(x: ox, y: oy, width: owidth, height: lastY)
            super.frame = newFrame
            self.frame = newFrame
            super.center = CGPoint.Center
            self.center = CGPoint.Center
            print("done..")
            
            
            self.setNeedsDisplay()
            
            /*
            // Get initial dimensions (title, subtitle, line)
            let topButtonY = self.subtitle.frame.maxY + 6
            let x = 0
            let width = super.frame.width // Only one button at the moment
            let height = BUTTON_HEIGHT
            let buttonRect = CGRect(x: CGFloat(x), y: topButtonY, width: width, height: CGFloat(height))
            button = UIButton(type: type) // if you want to set the type use like UIButton(type: .RoundedRect) or UIButton(type: .Custom)
            button.setTitle(title, for: .normal)
               button.frame = buttonRect                     //            IMPLEMENT AT END
            button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            print(buttonRect)
            //   button.backgroundColor = UIColor.brown
            
            var slot:CGFloat = 0
            var lastY: CGFloat = 0
            print("Expected Frame dimensions: \nX: same, Y: Different (+70), width: same, height: same (70)")
            //   print("-------------------------")
            print(buttons.count)
          //  var slotButtons = [UIButton] ()
            
            print("-------------------------")
            
           
            
            var bSlot = 0
            for slotButton in buttons {
                let buttonX = buttonRect.minX
                let buttonWidth = buttonRect.width
                let buttonHeight:CGFloat = CGFloat(BUTTON_HEIGHT)
                let buttonY = buttonRect.minY+(buttonHeight*slot)
                let buttonFrame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
                print(buttonFrame)
                let buttonType = slotButton.buttonType
                let buttonTitle = slotButton.titleLabel!.text
                let newSlotButton = UIButton(type: buttonType)
                newSlotButton.setTitle(buttonTitle, for: .normal)
                newSlotButton.frame = buttonFrame
                buttons[bSlot].removeFromSuperview()
                buttons[bSlot].frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                buttons[bSlot] = newSlotButton
                slot = slot + 1
                bSlot = bSlot + 1
                newSlotButton.backgroundColor = UIColor.lightBlue
            //   self.addSubview(newSlotButton)
                
            }
            
        
            print("-----------------------------------------")
            // for button in buttons, yVal = initial + (slotNumber*BUTTON_HEIGHT)
            
            // Add (Button Height * amount of buttons) to initial dimensions to get final size
            // Re-initialize frame of view with new dimensions
            let lb = buttons[buttons.count-1] as! UIButton
            let lby = lb.frame.maxY
            lastY = lby + CGFloat(BUTTON_HEIGHT)
            // Init main frame
            let ox = self.rectInScreen.minX
            let oy = self.rectInScreen.minY
            let owidth = self.rectInScreen.width
            let newFrame = CGRect(x: ox, y: oy, width: width, height: lastY)
            super.frame = newFrame
            self.frame = newFrame
            super.center = CGPoint.Center
            self.center = CGPoint.Center
            print("done..")
            
            
            self.setNeedsDisplay()
            */
            
            buttons[0].removeFromSuperview()
            
            print("Real button count: \(buttons.count)")
            if buttons[0].frame.width < super.frame.width {
                print("Widths:")
                print(buttons[0].frame.width)
                print(super.frame.width)
                print(self.rectInScreen.width)
                let w = super.frame.width
                let h = buttons[0].frame.height
                let myX = buttons[0].frame.minX
                let myY = buttons[0].frame.minY
                buttons[0].frame = CGRect(x: myX, y: myY, width: w*2, height: h)
                
                var b = buttons[0]
                b.removeFromSuperview()
                buttons[0].removeFromSuperview()
                let bcgr = CGRect(x: myX, y: myY, width: w, height: h)
                let someButton = UIButton(type: b.buttonType)
                someButton.frame = bcgr
                if let text = someButton.titleLabel?.text {
                    someButton.setTitle(text, for: .normal)
                }
                someButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
                someButton.titleLabel?.adjustsFontSizeToFitWidth = true
                b = someButton
                b.center = CGPoint.Center
                buttons[0] = b
                //     self.addSubview(b)
                
            }
        }
        if button == nil {
            button = UIButton()
        }
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        
        
        
        for b in buttons {
            print(b.frame.width)
         //   b.removeFromSuperview()
        }
        
        self.setNeedsDisplay()
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
