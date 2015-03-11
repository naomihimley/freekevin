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
    let rowFourButtonTitles = ["space", "return"]

    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonTitles()
    }
    
    //MARK: - UI Setup -

    func setButtonTitles () {
        // set way to get back to regular keyboard
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        self.nextKeyboardButton.setTitle("🌐", forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.nextKeyboardButton)
        
        // add the rest of the buttons
        let arrayOfRows = [rowOneButtonTitles, rowTwoButtonTitles, rowThreeButtonTitles, rowFourButtonTitles]

        var previousButton = self.view
        var incrementingX = CGFloat(0)
        var incrementingY = CGFloat(0)
        for row in arrayOfRows {
            let buttonWidth = (UIScreen.mainScreen().bounds.width / CGFloat(row.count))
            for title in row {
                let currentButton = UIButton(frame: CGRectMake(incrementingX, incrementingY, buttonWidth, buttonWidth))
                currentButton.setTitle(title, forState: .Normal)
                currentButton.setTranslatesAutoresizingMaskIntoConstraints(false)
                currentButton.backgroundColor = UIColor.redColor()
                //add it to the subview
                self.view.addSubview(currentButton)
                //TODO: add constraints and Target
                //update the incrementing variables
                incrementingX += buttonWidth + buttonSpacing
                previousButton = currentButton
            }
            incrementingY += 35;
            incrementingX = 0;
        }
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
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
