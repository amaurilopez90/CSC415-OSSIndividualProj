//
//  Routing.swift
//  Gud-Food
//
//  Created by Amauri Lopez on 11/30/17.
//  Copyright © 2017 Amauri Lopez. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import CoreLocation

class Routing {
    
    var settings = MapSettings()
    var Map = MapViewController()
    func Route(sourceCoordinates: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> Array<MKRoute>{
        
        //create placemarks and map items for source and destination
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates)
        let destPlacemark = MKPlacemark(coordinate: destination)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        //set up the different kinds of direction requests
        let drivingDirectionsRequest = MKDirectionsRequest()
        let transitDirectionsRequest = MKDirectionsRequest()
        let walkingDirectionsRequest = MKDirectionsRequest()
        
        drivingDirectionsRequest.transportType = .automobile
        transitDirectionsRequest.transportType = .transit
        walkingDirectionsRequest.transportType = .walking
        
        
        //populate a directions request array: Direction requests from Apple Cloud
        var directionRequests = Array<MKDirectionsRequest>()
        
        var settingsTable = settings.getSettings() //get current settings to filter routes
        
        if settingsTable[1] == true{
            directionRequests.append(drivingDirectionsRequest)
        }//if driving directions is enabled
        
        if settingsTable[2] == true{
            directionRequests.append(transitDirectionsRequest)
        }//if transit directions is enabled
        
        if settingsTable[3] == true{
            directionRequests.append(walkingDirectionsRequest)
        }//if walking directions is enabled
        
        var routes = Array<MKRoute>()
        var rancompletion = Bool()
        
        for directionRequest in directionRequests{
            directionRequest.source = sourceItem
            directionRequest.destination = destItem
            
            rancompletion = false
            
            var directions = MKDirections(request: directionRequest)
            
            //this line of code is an asynchronous task, and do this function ends before this task completion.
            //because of this, the function's result is wrong, and so no roots are displayed
            directions.calculate(completionHandler: {(response, error) in
                
                rancompletion = true
                if error != nil{
                    //if error
                    print ("Could not get")
                    if directionRequest.transportType == .automobile{
                        print("Driving directions")
                    }else if directionRequest.transportType == .transit{
                        print("Transit directions")
                    }else if directionRequest.transportType == .walking{
                        print ("Walking directions")
                    }
                }else{
                    //if no error
                    routes.append((response?.routes[0])!)
                }
            })
        }
        return routes
    }

}
