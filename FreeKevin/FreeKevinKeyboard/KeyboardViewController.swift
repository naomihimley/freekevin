//
//  KeyboardViewController.swift
//  FreeKevinKeyboard
//
//  Created by Naomi Himley on 3/8/15.
//  Copyright (c) 2015 Naomi Himley. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    let buttonSpacing = CGFloat(4)
    let rowOneButtonTitles = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let rowTwoButtonTitles = ["A", "S", "D", "F", "G", "H", "J", "K", "L", ";"]
    let rowThreeButtonTitles = ["🔮", "^", "Z", "X", "C", "V", "B", "N", "M", "🔙"]
    let rowFourButtonTitles = ["🌐", "space", "return",]
    var shiftKeyToggle = false
    var advancedToggle = false
    let keyboardView = UIView()

//MARK: - View Setup

    override func viewDidLoad() {
        //Kind of a weird hack to be able to use autolayout. Its difficult to get the height of self.inputView until you have added one subview for some reason
        //So instead of adding a dummy view I just added a whole keyboardView, with constraints of 0 to match self.inputView
        super.viewDidLoad()
        keyboardView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.inputView.addSubview(keyboardView)
        var leftConstraint = NSLayoutConstraint(item: keyboardView, attribute: .Left, relatedBy: .Equal, toItem: self.inputView, attribute: .Left, multiplier: 1.0, constant:0)
        var rightConstraint = NSLayoutConstraint(item: keyboardView, attribute: .Right, relatedBy: .Equal, toItem: self.inputView, attribute: .Right, multiplier: 1.0, constant:0)
        var bottomConstraint = NSLayoutConstraint(item: keyboardView, attribute: .Bottom, relatedBy: .Equal, toItem: self.inputView, attribute: .Bottom, multiplier: 1.0, constant: 0)
        var topConstraint = NSLayoutConstraint(item: keyboardView, attribute: .Top, relatedBy: .Equal, toItem: self.inputView, attribute: .Top, multiplier: 1.0, constant: 0)
        self.inputView.addConstraints([leftConstraint, rightConstraint, bottomConstraint, topConstraint])
    }
    
    override func viewDidAppear(animated: Bool) {
        self.setUpButtons()
    }
    
    func setUpButtons () {
        let arrayOfRows = [rowOneButtonTitles, rowTwoButtonTitles, rowThreeButtonTitles, rowFourButtonTitles]
        var incrementingX = buttonSpacing
        var incrementingY = buttonSpacing * 2
        var rowIndex = 0
        var buttonHeight = CGFloat()
        var currentRow = [UIButton]() //array of UIButtons in each row
        
        for rowTitles in arrayOfRows {
            let buttonWidth = (CGRectGetWidth(UIScreen.mainScreen().bounds) - buttonSpacing * (CGFloat(rowTitles.count) + 1)) / CGFloat(rowTitles.count)
            buttonHeight = CGRectGetHeight(keyboardView.frame) / CGFloat(arrayOfRows.count) -  (buttonSpacing * CGFloat(arrayOfRows.count))
            for title in rowTitles {
                let currentButton = self.newCreateButtonWithTitle(title)
                currentButton.frame = CGRectMake(incrementingX, incrementingY, buttonWidth, buttonHeight + buttonSpacing * 2)
                currentRow.append(currentButton)
                incrementingX += buttonWidth + buttonSpacing
                keyboardView.addSubview(currentButton)
            }
            let anyButton = currentRow.first
            if (keyboardView.frame.height > 0) {
                self.addIndividualButtonConstraints(currentRow, yVar: incrementingY)
            }
            //Next row: increment the Y
            incrementingY += CGRectGetHeight(anyButton!.frame) + buttonSpacing
            //and set everything else back to the beginning for the next row
            currentRow = [UIButton]()
            incrementingX = buttonSpacing
            rowIndex++
        }
    }
    
    /// This method adds constraints to a single row of buttons to the keyboardView and to each other
    ///
    /// :rowOfButtons: An array of UIButtons in a row
    /// :yVar: A CGFloat value that represents the Y coordinate within keyboardView this row should be
    func addIndividualButtonConstraints(rowOfButtons: [UIButton], yVar: CGFloat) {
        for (index, button) in enumerate(rowOfButtons) {
//Top
            var topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: keyboardView, attribute: .Top, multiplier: 1.0, constant: yVar)
//Bottom
            let bottomConstant = CGRectGetHeight(keyboardView.frame) - yVar - CGRectGetHeight(button.frame) - buttonSpacing
            var bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: keyboardView, attribute: .Bottom, multiplier: 1.0, constant: -bottomConstant)
//Width
            var widthConstraint : NSLayoutConstraint!
//Right
            var rightConstraint : NSLayoutConstraint!
            if (index == rowOfButtons.count - 1) { //it is the last in the row
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: keyboardView, attribute: .Right, multiplier: 1.0, constant: -buttonSpacing)
                let prevButton = rowOfButtons[index - 1]
                widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: prevButton, attribute: .Width, multiplier: 1.0, constant:0)
            }
            else {
                let nextButton = rowOfButtons[index + 1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: nextButton, attribute: .Left, multiplier: 1.0, constant:  -buttonSpacing)
                widthConstraint = NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nextButton, attribute: .Width, multiplier: 1.0, constant:0)
            }
//Left
            var leftConstraint : NSLayoutConstraint!
            if index == 0 { //it is first button in the row
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: keyboardView, attribute: .Left, multiplier: 1.0, constant: buttonSpacing)
                
            }
            else {
                let prevButton = rowOfButtons[index - 1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: prevButton, attribute: .Right, multiplier: 1.0, constant: buttonSpacing)
            }
//Add all constraints to keyboardView
            keyboardView.addConstraints([leftConstraint, rightConstraint, bottomConstraint, topConstraint, widthConstraint])
        }
    }
    
    func newCreateButtonWithTitle(title:String) -> UIButton {
        let button: UIButton = UIButton.buttonWithType(.System) as! UIButton
        button.layer.cornerRadius = buttonSpacing
        button.clipsToBounds = true
        button.setTitle(title, forState: .Normal)
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.backgroundColor = UIColor.grayColor()
        button.addTarget(self, action:"didTapButton:", forControlEvents: .TouchUpInside)
        return button
    }
 
    //MARK: - Translating Text -
    
    func didTapButton(sender: AnyObject?) {
        let button = sender as! UIButton
        var proxy = textDocumentProxy as! UITextDocumentProxy
        let title = button.titleForState(.Normal)!
        switch title {
        case "^" :
            button.backgroundColor = shiftKeyToggle ? UIColor.grayColor() : UIColor.whiteColor()
            button.setTitleColor(shiftKeyToggle ? UIColor.whiteColor() : UIColor.blackColor(), forState: .Normal)
            shiftKeyToggle = !shiftKeyToggle
        case "🌐" : //change keyboards
            self.advanceToNextInputMode()
        case "🔙" :
            proxy.deleteBackward()
        case "space" :
            proxy.insertText(" ")
        case "return" :
            proxy.insertText("\n")
        case "🔮" :
            button.backgroundColor = advancedToggle ? UIColor.grayColor() : UIColor.whiteColor()
            button.setTitleColor(advancedToggle ? UIColor.whiteColor() : UIColor.blackColor(), forState: .Normal)
            advancedToggle = !advancedToggle
        default :
            var leetVersion = self.changeToLeet(title)
            leetVersion = shiftKeyToggle ? leetVersion.uppercaseString : leetVersion.lowercaseString
            proxy.insertText(leetVersion)
        }
    }
    
    func changeToLeet(input: String?) -> String {
        var updatedString = String()
        switch input! {
        case "W":
            updatedString = self.advancedToggle ? "'//" : input!
        case "E":
            updatedString = "3"
        case "R":
            updatedString = self.advancedToggle ? "|2" : input!
        case "T":
            updatedString = "7"
        case "Y":
            updatedString = self.advancedToggle ? "`/" : input!
        case "U":
            updatedString = self.advancedToggle ? "(_)" : input!
        case "I":
            updatedString = self.advancedToggle ? "!" : "1"
        case "O":
            updatedString = "0"
        case "P":
            updatedString = self.advancedToggle ? "|D" : input!
        case "A":
            updatedString = "4"
        case "S":
            updatedString = "5"
        case "D":
            updatedString = self.advancedToggle ? "|)" : input!
        case "F":
            updatedString = self.advancedToggle ? "|=" : input!
        case "G":
            updatedString = "6"
        case "H":
            updatedString = self.advancedToggle ? "|-|" : input!
        case "J":
            updatedString = self.advancedToggle ? "_|" : input!
        case "K":
            updatedString = self.advancedToggle ? "|<" : input!
        case "L":
            updatedString = self.advancedToggle ? "|_" : input!
        case "Z":
            updatedString = self.advancedToggle ? "2" : input!
        case "X":
            updatedString = self.advancedToggle ? "><" : input!
        case "C":
            updatedString = self.advancedToggle ? "(" : input!
        case "V":
            updatedString = self.advancedToggle ? "\\/" : input!
        case "B":
            updatedString = self.advancedToggle ? "|3" : input!
        case "N":
            updatedString = self.advancedToggle ? "|\\|" : input!
        case "M":
            updatedString = self.advancedToggle ? "/\\/\\" : input!
        default:
            updatedString = input!
        }
        return updatedString
    }
}
