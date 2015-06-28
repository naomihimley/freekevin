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
    struct HomeVCConstants {
        static let kCellReuseID = "FKReuseIdentifier"
        static let kInstallationStoryboardID = "FKInstallationInstructionsStoryboardID"
        static let kKeyboardUseStoryboardID = "FKKeyboardUseViewControllerStoryboardID"
        static let kPracticeStoryboardID = "FKPracticeStoryboardID"
    }
    enum Cells : Int {
        case Installation
        case Use
        case Practice
    }
    
    //MARK: - Views -
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set home screen UI
        welcomeLabel.text = NSLocalizedString("Welcome to FreeKevin a keyboard translation for Leet or 1337.", comment: "Welcome text for home screen")
    }

    //Unwind Segue for dismissing Practice VC and Info VC
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    //MARK: - Table View Methods -
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:HomeVCConstants.kCellReuseID)
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.greenColor()
        cell.textLabel?.font = UIFont.systemFontOfSize(18)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        if let row = Cells(rawValue: indexPath.row){
            switch (row) {
            case .Installation:
                cell.textLabel?.text = NSLocalizedString("Installation Instructions", comment: "Cell text for Installation cell")
            case .Use:
                cell.textLabel?.text = NSLocalizedString("Keyboard Use Instructions", comment: "Cell text for Keyboard Use cell")
            case .Practice:
                cell.textLabel?.text = NSLocalizedString("Practice", comment: "Cell text for Practice cell")
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let row = Cells(rawValue: indexPath.row) {
            switch (row) {
            case .Installation:
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier(HomeVCConstants.kInstallationStoryboardID) as! FKInstallationInstructionsViewController
                self.presentViewController(vc, animated: true, completion: nil)
            case .Use:
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier(HomeVCConstants.kKeyboardUseStoryboardID) as! FKKeyboardUseViewController
                self.presentViewController(vc, animated: true, completion: nil)
            case .Practice:
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier(HomeVCConstants.kPracticeStoryboardID) as! FKPracticeViewController
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }
        //After presenting the new VC deselect the cell so it is not still selected when they come back to home
        tableView.deselectRowAtIndexPath(indexPath, animated:false)
    }

}

