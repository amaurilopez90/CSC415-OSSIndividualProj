//
//  MapSettings.swift
//  Gud-Food
//
//  Created by Amauri Lopez on 11/29/17.
//  Copyright © 2017 Amauri Lopez. All rights reserved.
//

import Foundation

class MapSettings: UITableViewController{
    
    @IBOutlet weak var UndoSettingChangesButton: UIBarButtonItem!
    @IBOutlet weak var SaveSettingsButton: UIBarButtonItem!
    @IBOutlet weak var WalkingSwitch: UISwitch!
    @IBOutlet weak var DrivingSwitch: UISwitch!
    @IBOutlet weak var OpenNavTab: UIBarButtonItem!
    @IBOutlet weak var StampsSwitch: UISwitch!
    @IBOutlet weak var TransitSwitch: UISwitch!
    
    private var SettingsTableArray: [Bool] = [true, true, true, true]
    
    private var stampsVal = Bool()
    private var drivingVal = Bool()
    private var transitVal = Bool()
    private var walkingVal = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OpenNavTab.target = self.revealViewController()
        OpenNavTab.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) //add the gesture recognition
        
        setSettings(stampsVal: StampsSwitch.isOn, drivingVal: DrivingSwitch.isOn, transitVal: TransitSwitch.isOn, walkingVal: WalkingSwitch.isOn)
        
    }
    
    //gettings and setters
    func setSettings(stampsVal: Bool, drivingVal: Bool, transitVal: Bool, walkingVal: Bool){
        SettingsTableArray = [stampsVal, drivingVal, transitVal, walkingVal]
    }
    func getSettings() -> Array<Bool>{
        return SettingsTableArray
    }
    
    @IBAction func stampsValChanged(_ sender: UISwitch) {
        SaveSettingsButton.isEnabled = true
        UndoSettingChangesButton.isEnabled = true
        stampsVal = sender.isOn
    }

    @IBAction func drivingValChanged(_ sender: UISwitch) {
        SaveSettingsButton.isEnabled = true
        UndoSettingChangesButton.isEnabled = true
        drivingVal = sender.isOn
    }
    

    @IBAction func transitValChanged(_ sender: UISwitch) {
        SaveSettingsButton.isEnabled = true
        UndoSettingChangesButton.isEnabled = true
        transitVal = sender.isOn
    }

    
    @IBAction func walkingValChanged(_ sender: UISwitch) {
        SaveSettingsButton.isEnabled = true
        UndoSettingChangesButton.isEnabled = true
        walkingVal = sender.isOn
    }
    
    
    //save the setting and repopulate the settings table
    @IBAction func saveSettings(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Save", message: "Save Current Settings?", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {(action) -> Void in
            self.setSettings(stampsVal: self.StampsSwitch.isOn, drivingVal: self.DrivingSwitch.isOn, transitVal: self.TransitSwitch.isOn, walkingVal: self.WalkingSwitch.isOn)
            
            print("Settings Saved")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in
            print("Cancelled Save")
        })
        
        //Add Save and Cancel button to dialog
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        //Present dialog message to user
        present(alert, animated: true, completion: nil)
    
    
    }
    //undo current changes, revert the buttons back to original states
    @IBAction func undoChanges(_ sender: UIBarButtonItem) {
        let settings = getSettings()
        StampsSwitch.isOn = settings[0]
        DrivingSwitch.isOn = settings[1]
        TransitSwitch.isOn = settings[2]
        WalkingSwitch.isOn = settings[3]
    }
    
    
}
