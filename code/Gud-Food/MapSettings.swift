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
    @IBOutlet weak var BusSwitch: UISwitch!
    @IBOutlet weak var DrivingSwitch: UISwitch!
    @IBOutlet weak var StampsSwitch: UISwitch!
    @IBOutlet weak var OpenNavTab: UIBarButtonItem!
    
    private var SettingsTableArray = [Bool]() //array of Boolean values for each setting
    
    private var stampsVal = Bool()
    private var drivingVal = Bool()
    private var busVal = Bool()
    private var walkingVal = Bool()
    
    override func viewDidLoad() {
        
        OpenNavTab.target = self.revealViewController()
        OpenNavTab.action = #selector(SWRevealViewController.revealToggle(_:))
        
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) //add the gesture recognition
        
        //grab initial states of switches
        SettingsTableArray[0] = StampsSwitch.isOn
        SettingsTableArray[1] = DrivingSwitch.isOn
        SettingsTableArray[2] = DrivingSwitch.isOn
        SettingsTableArray[3] = DrivingSwitch.isOn
        
    }
    
    //gettings and setters
    func getSettings() -> Array<Bool>{
        return SettingsTableArray
    }
    func setSettings(stampsVal: Bool, drivingVal: Bool, busVal: Bool, walkingVal: Bool){
        SettingsTableArray[0] = stampsVal
        SettingsTableArray[1] = drivingVal
        SettingsTableArray[2] = busVal
        SettingsTableArray[3] = walkingVal
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
    
    @IBAction func busValChanged(_ sender: UISwitch) {
        SaveSettingsButton.isEnabled = true
        UndoSettingChangesButton.isEnabled = true
        busVal = sender.isOn
    }
    
    @IBAction func walkingValChanged(_ sender: UISwitch) {
        SaveSettingsButton.isEnabled = true
        UndoSettingChangesButton.isEnabled = true
        walkingVal = sender.isOn
    }
    
    
    //save the setting and repopulate the settings table
    @IBAction func saveSettings(_ sender: UIBarButtonItem) {
        setSettings(stampsVal: stampsVal, drivingVal: drivingVal, busVal: busVal, walkingVal: walkingVal)
    }
    
    //undo current changes, revert the buttons back to original states
    @IBAction func undoChanges(_ sender: UIBarButtonItem) {
        StampsSwitch.isOn = SettingsTableArray[0]
        DrivingSwitch.isOn = SettingsTableArray[1]
        BusSwitch.isOn = SettingsTableArray[2]
        WalkingSwitch.isOn = SettingsTableArray[3]
    }
    
    
}
