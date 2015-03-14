//
//  KeyboardViewController.swift
//  FreeKevinKeyboard
//
//  Created by Naomi Himley on 3/8/15.
//  Copyright (c) 2015 Naomi Himley. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    let buttonSpacing = CGFloat(5)
    let rowOneButtonTitles = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let rowTwoButtonTitles = ["A", "S", "D", "F", "G", "H", "J", "K", "L", ";"]
    let rowThreeButtonTitles = ["^", "Z", "X", "C", "V", "B", "N", "M", "🔙"]
    let rowFourButtonTitles = ["🌐", "space", "return", "advanced"]
    var shiftKeyToggle = false
    var advancedToggle = false

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonTitles()
    }
    
    //MARK: - UI Setup -
    
    //TODO: Update spacing to calculate better and add constraints

    func setButtonTitles () {
        let arrayOfRows = [rowOneButtonTitles, rowTwoButtonTitles, rowThreeButtonTitles, rowFourButtonTitles]
        var previousButton = self.view //for constraints
        var incrementingX = buttonSpacing
        var incrementingY = buttonSpacing
        var rowIndex = 0
        var buttonHeight = CGFloat()
        for row in arrayOfRows {
            let buttonWidth = (CGRectGetWidth(UIScreen.mainScreen().bounds) - buttonSpacing * CGFloat(row.count)) / CGFloat(row.count)
            //base the button height on first row width
            if rowIndex == 0 {
                buttonHeight = buttonWidth
            }
            for title in row {
                let currentButton = self.createButtonWithTitle(title, x: incrementingX, y: incrementingY, width:buttonWidth, height:buttonHeight)
                self.view.addSubview(currentButton)
                currentButton.addTarget(self, action:"didTapButton:", forControlEvents: .TouchUpInside)
                previousButton = currentButton
                incrementingX += buttonWidth + buttonSpacing
            }
            incrementingY += buttonWidth + buttonSpacing * 5
            incrementingX = buttonSpacing
            rowIndex++
        }
    }
    
    func createButtonWithTitle(title: String, x: CGFloat, y: CGFloat, width:CGFloat, height:CGFloat) -> UIButton {
        let button = UIButton(frame: CGRectMake(x, y, width, height + buttonSpacing * 3))
        button.layer.cornerRadius = buttonSpacing;
        button.clipsToBounds = true;
        button.setTitle(title, forState: .Normal)
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        button.backgroundColor = UIColor.grayColor()
        return button
    }
    
    //MARK: - Stock Text Methods -
    
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        }
        else {
            textColor = UIColor.blackColor()
        }
    }
    
    func didTapButton(sender: AnyObject?) {
        let button = sender as UIButton
        var proxy = textDocumentProxy as UITextDocumentProxy
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
        case "advanced" :
            button.backgroundColor = advancedToggle ? UIColor.grayColor() : UIColor.whiteColor()
            button.setTitleColor(advancedToggle ? UIColor.whiteColor() : UIColor.blackColor(), forState: .Normal)
            advancedToggle = !advancedToggle
        default :
            //automatically uppercase before checking if we are changing the string first, so don't have to check
            //"A"  and "a" in the switch. Then check our toggle to see if the output should really be capitalized
            var leetVersion = self.changeToLeet(title.uppercaseString)
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
