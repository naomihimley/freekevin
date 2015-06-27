//
//  FKPracticeViewController.swift
//  FreeKevin
//
//  Created by Naomi Himley on 6/26/15.
//  Copyright (c) 2015 Naomi Himley. All rights reserved.
//

import UIKit

class FKPracticeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Create and set Tap Gesture Recognizer for dismissing keyboard
        var tapGesture = UITapGestureRecognizer(target: self, action:"dismissKeyboard")
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}
