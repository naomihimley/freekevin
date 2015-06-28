//
//  FKInstallationInstructionsViewController.swift
//  FreeKevin
//
//  Created by Naomi Himley on 6/26/15.
//  Copyright (c) 2015 Naomi Himley. All rights reserved.
//

import UIKit

class FKInstallationInstructionsViewController: UIViewController {

    @IBOutlet weak var instructionTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Instruction Text
        instructionTextView.text = NSLocalizedString("1. Open Settings App \n2. General \n3. Keyboard \n3. Keyboards \n4. Add New Keyboard \n5. Select FreeKevin", comment: "Instruction text for how to set up custom keyboards in settings")
        instructionTextView.textColor = UIColor.greenColor()
        instructionTextView.font = UIFont.systemFontOfSize(18)
    }
}
