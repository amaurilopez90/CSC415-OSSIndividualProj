//
//  MapSettings.swift
//  Gud-Food
//
//  Created by Amauri Lopez on 11/29/17.
//  Copyright © 2017 Amauri Lopez. All rights reserved.
//

import Foundation

class MapSettings: UITableViewController{
    var SettingsTableArray = [String]() //array of strings
    
    
    override func viewDidLoad() {
        
        SettingsTableArray = ["Search Radius:", "Food Stamps Only:", "Driving Routes", "Bus Routes"]
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) //add the gesture recognition
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsTableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = SettingsTableArray[indexPath.row] //set the label inside the cell to the label at index in SettingsTableArray
        
        return cell
    }
    
    
}
