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
    func Route(sourceCoordinates: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, completion: @escaping (_ error: Error?, _ response: MKDirectionsResponse?, _ directionRequest: MKDirectionsRequest) -> ()){
        
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
        
        for directionRequest in directionRequests{
            directionRequest.source = sourceItem
            directionRequest.destination = destItem
            
            
            var directions = MKDirections(request: directionRequest)
            
            //this line of code is an asynchronous task, and this function ends before this task completes.
            //because of this, the function's result is wrong, and so no roots are displayed
            directions.calculate(completionHandler: {(response, error) in
                if let route = response?.routes.first{
                    print("Getting routes")
                }
                completion(error, response, directionRequest)

            })
            
        }
        
    }

}
