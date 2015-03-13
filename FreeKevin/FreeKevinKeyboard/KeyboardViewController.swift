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
    let rowFourButtonTitles = ["🌐", "space", "return"]
    var shiftKeyToggle = false

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonTitles()
    }
    
    //MARK: - UI Setup -

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
            incrementingY += buttonWidth + buttonSpacing
            incrementingX = buttonSpacing
            rowIndex++
        }
    }
    
    func createButtonWithTitle(title: String, x: CGFloat, y: CGFloat, width:CGFloat, height:CGFloat) -> UIButton {
        let button = UIButton(frame: CGRectMake(x, y, width, height))
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
        default :
            var titleCapsOrNot = String()
            titleCapsOrNot = shiftKeyToggle ? title.uppercaseString : title.lowercaseString
            proxy.insertText(titleCapsOrNot)
        }
    }
}
