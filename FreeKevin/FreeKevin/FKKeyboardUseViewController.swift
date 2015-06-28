//
//  FKKeyboardUseViewController.swift
//  FreeKevin
//
//  Created by Naomi Himley on 6/26/15.
//  Copyright (c) 2015 Naomi Himley. All rights reserved.
//

import UIKit

class FKKeyboardUseViewController: UIViewController {

    @IBOutlet weak var instructionsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsTextView.text = NSLocalizedString("This keyboard is not meant to be an extensive translation for real leet. Like any slang leet varies in different cliques and scenes. This is only meant to be a quick and fun way to use one version of leet. That being said here are a few things about the keyboard. \nMost importantly use the 🌐 key to switch back to the system keyboard \nThe 🔮 key operates similarly to a shift key except that instead of capitalizing letters it adds a harder to read version. For example the letter Y does not change on the default Leet keyboard but with the 🔮 shift on it becomes: `/ \nSome letters are the same with or without the 🔮 key on. E is always 3 for example.", comment: "Instructions on use of Keyboard")
    }
}
