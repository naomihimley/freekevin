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

        var previousButton = self.view
        var incrementingX = buttonSpacing
        var incrementingY = buttonSpacing
        var rowIndex = 0
        for row in arrayOfRows {
            let buttonWidth = (CGRectGetWidth(UIScreen.mainScreen().bounds) - buttonSpacing * CGFloat(row.count)) / CGFloat(row.count)
            for title in row {
                if rowIndex == arrayOfRows.count - 1 {
                    if (title == "🌐") {
                        // set way to get back to regular keyboard
                        let nextKeyboardButton = self.createButtonWithTitle(title, x: incrementingX, y: incrementingY, width:buttonWidth)
                        self.view.addSubview(nextKeyboardButton)
                        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
                        previousButton = nextKeyboardButton
                    }
                    else {
                        //TODO: set up the space bar and the return key
                        let currentButton = self.createButtonWithTitle(title, x: incrementingX, y: incrementingY, width:buttonWidth)
                        self.view.addSubview(currentButton)
                        previousButton = currentButton
                    }
                }
                else {
                    let currentButton = self.createButtonWithTitle(title, x: incrementingX, y: incrementingY, width:buttonWidth)
                    self.view.addSubview(currentButton)
                    currentButton.addTarget(self, action:"didTapButton:", forControlEvents: .TouchUpInside)
                    previousButton = currentButton
                }
                incrementingX += buttonWidth + buttonSpacing
            }
            incrementingY += buttonWidth + buttonSpacing
            incrementingX = buttonSpacing
            rowIndex++
        }
    }
    func createButtonWithTitle(title: String, x: CGFloat, y: CGFloat, width:CGFloat) -> UIButton {
        let button = UIButton(frame: CGRectMake(x, y, width, width))
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
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
    }
    func didTapButton(sender: AnyObject?) {
        
        let button = sender as UIButton
        let title = button.titleForState(.Normal)
        var proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.insertText(title!)
    }

}
