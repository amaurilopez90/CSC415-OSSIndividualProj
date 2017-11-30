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
    func Route(destination: MKPointAnnotation) -> MKRoute{
        
        //create placemarks and map items for source and destination
        let sourcePlacemark = MKPlacemark(coordinate: destination.coordinate)
        let destPlacemark = MKPlacemark(coordinate: destination.coordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        //populate a directions request array
        var directionRequests = Array<MKDirectionsRequest>()
        
        var settingsTable = settings.getSettings() //get current settings to filter routes
        if settingsTable[1] == true{
            //directions request from Apple Cloud
            directionRequests[0].source = sourceItem
            directionRequests[0].destination = destItem
            directionRequests[0].transportType = .automobile
        }//if driving directions is enabled
        
        if settingsTable[2] == true{
            directionRequests[1].source = sourceItem
            directionRequests[1].destination = destItem
            directionRequests[1].transportType = .transit
        }
        if settingsTable[3] == true{
            directionRequests[2].source = sourceItem
            directionRequests[2].destination = destItem
            directionRequests[2].transportType = .walking
        }
        
        
        let directions = MKDirections(request: directionRequest)
        var route = MKRoute()
        directions.calculate(completionHandler: {
            response, error in
            
            guard let response = response else{
                if let error = error{
                    print("Something went wrong, there might not be a driving route")
                }
                return
            }
            
            route = response.routes[0] //grab first route (fastest one)

        })
        return route
    }
}
