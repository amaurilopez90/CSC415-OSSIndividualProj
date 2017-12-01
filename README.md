# CSC415-OSSIndividualProj: Gud-Food
Open Source Software individual project for CSC415 - Software Engineering

Link to Repo: https://github.com/amaurilopez90/CSC415-OSSIndividualProj.git

Description:
  Gud-Food is an iOS mobile applcation that is supposed to help improve access to food markets/vendors in the area for those who may have not already have access. This app is supposed to display nearby food markets/vendors in the area and allow the user to display routes to these places based on certain Settings criteria (e.g. Whether or not the user has access to transit, or an automobile, or is just planning to walk)

Using for Simulation:
  . Navigate to CSC415-OSSIndividualProj/code/ to download the XCode project files
  . OR Clone repository to local machine and open XCode project
  . Run the Simulator
  
Notes:
  . Gud-Food is expected to run on iOS 9 or later versions
  . Simulated devices are tested using iPhone 7 Plus Simulation
  . Required Frameworks:
      . MapKit
      . CoreLocation
  
Known Limitations & Bugs:
  . Application cannot currently display routes to destinations
    This is due to an asynchronous MKDirectionsRequest method which requests direction calculation data from the Apple Cloud. 
    During execution inside the Routing Class, the flow of control does not remain linear and function exits with an empty routes list.
    
    Suggested Fix: Must implement delay or completion method to run while the Direction Request's completion handler prepares to execute
                   upon request completion
                   
  . Application cannot currently filter annotations based on Stamps Only setting. Annotations do not exhibit a property to hold stamps         info.
  
    Suggested Fix: create custom annotations class with stamps attribute. 
    
  . SettingsTable initialization method requires a UITableView initialization method to be called, yet does not have distinct init()
    SettingsTable was thus populated by assumption, knowing that all states would be set to true initially.
    
    
