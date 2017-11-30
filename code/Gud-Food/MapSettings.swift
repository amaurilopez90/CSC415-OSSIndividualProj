//
//  MapSettings.swift
//  Gud-Food
//
//  Created by Amauri Lopez on 11/29/17.
//  Copyright © 2017 Amauri Lopez. All rights reserved.
//

import Foundation

class MapSettings: UITableViewController{
    
    @IBOutlet weak var OpenNavTab: UIBarButtonItem!
    
    var SettingsTableArray = [String]() //array of strings
    
    
    override func viewDidLoad() {
        
        OpenNavTab.target = self.revealViewController()
        OpenNavTab.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) //add the gesture recognition
    }
    
    
}
