//
//  FKHomeViewController.swift
//  FreeKevin
//
//  Created by Naomi Himley on 3/8/15.
//  Copyright (c) 2015 Naomi Himley. All rights reserved.
//

import UIKit

class FKHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var actionsTableView: UITableView!
    enum Cells : Int {
        case Installation
        case Use
        case Practice
    }
    
    //MARK: - Views -
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set home screen UI
        welcomeLabel.text = NSLocalizedString("Welcome to FakeHax a keyboard translation for Leet or 1337.", comment: "Welcome text for home screen")
    }

    //Unwind Segue for dismissing Practice VC and Info VC
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    //MARK: - Table View Methods -
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier: "FKReuseIdentifier")
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.tintColor = UIColor.greenColor()
        if let row = Cells(rawValue: indexPath.row){
            switch (row) {
            case .Installation:
                cell.textLabel?.text = "Installation Instructions"
            case .Use:
                cell.textLabel?.text = "Keyboard Use Instructions"
            case .Practice:
                cell.textLabel?.text = "Practice"
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let row = Cells(rawValue: indexPath.row) {
            switch (row) {
            case .Installation:
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier("FKInstructionsStoryboardID") as! FKInstructionsViewController
                self.presentViewController(vc, animated: true, completion: nil)
            case .Use:
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier("FKKeyboardInstructionsStoryboardID") as! FKKeyboardInstructionsViewController
                self.presentViewController(vc, animated: true, completion: nil)
            case .Practice:
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier("FKPracticeStoryboardID") as! FKPracticeViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }
    }
}

