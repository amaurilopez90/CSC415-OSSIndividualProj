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
    func Route(destination: MKPointAnnotation) -> Array<MKRoute>{
        
        //create placemarks and map items for source and destination
        let sourcePlacemark = MKPlacemark(coordinate: destination.coordinate)
        let destPlacemark = MKPlacemark(coordinate: destination.coordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        //set up the different kinds of direction requests
        var drivingDirectionsRequest = MKDirectionsRequest()
        var transitDirectionsRequest = MKDirectionsRequest()
        var walkingDirectionsRequest = MKDirectionsRequest()
        
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
        
        for directionRequest in directionRequests{
            directionRequest.source = sourceItem
            directionRequest.destination = destItem
            
            var directions = MKDirections(request: directionRequest)
            directions.calculate(completionHandler: {
                response, error in
                
                guard let response = response else{
                    if let error = error{
                        print("Could not get ")
                        if directionRequest.transportType == .automobile{
                            print("Driving directions")
                        }
                        if directionRequest.transportType == .transit{
                            print("Transit directions")
                        }
                        if directionRequest.transportType == .walking{
                            print("Walking directions")
                        }
                    }
                    return
                }
                
                routes.append(response.routes[0]) //append the fastest route for that direction request
            })
        }
        
        return routes
    }
}
