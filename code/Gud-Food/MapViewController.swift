//
//  ViewController.swift
//  Gud-Food
//
//  Created by Amauri Lopez on 11/29/17.
//  Copyright © 2017 Amauri Lopez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    //create necessary outlets
    @IBOutlet weak var Map: MKMapView!
    @IBOutlet weak var OpenNavTab: UIBarButtonItem!
    @IBOutlet weak var BtnRoute: UIBarButtonItem!
    
    //set up required variables
    private let manager = CLLocationManager()
    private let reuseIdentifier = "MyIdentifier"
    private var myLocation = CLLocationCoordinate2D()
    private var span = MKCoordinateSpan()
    private var region = MKCoordinateRegion()
    private var destination = CLLocationCoordinate2D()
    var routeIt = Routing()
    
    //getters and setters
    func setMyLocation(_ coordinate: CLLocationCoordinate2D){
        myLocation = coordinate
    }
    
    func getMyLocation() -> CLLocationCoordinate2D{
        return myLocation
    }
    func setSpan(_ latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        span = MKCoordinateSpanMake(latitude, longitude)
    }
    func getSpan() -> MKCoordinateSpan{
        return span
    }
    func setRegion(_ center: CLLocationCoordinate2D, span: MKCoordinateSpan){
        region = MKCoordinateRegionMake(center, span)
    }
    func getRegion() -> MKCoordinateRegion{
        return region
    }
    func getReuseIdentifier() -> String{
        return reuseIdentifier
    }
    
    //annotation view customization
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation.coordinate.latitude == myLocation.latitude && annotation.coordinate.longitude == myLocation.longitude) {return nil} //if the annotation is the users location, then don't bother with customizing the annotation
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else { annotationView?.annotation = annotation }
        
        return annotationView

    }
    
    //When user selects and deselects annotations, enable/disable the 'route' btn
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if !(view.annotation?.coordinate.latitude == myLocation.latitude && view.annotation?.coordinate.longitude == myLocation.longitude){ //don't enable the 'Route' button if the selected annotation is the user's own location
            BtnRoute.isEnabled = true
            destination = (view.annotation?.coordinate)!//set the target destination as the currently selected location
        }

    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        BtnRoute.isEnabled = false
    }
    
    //what happens when the user hits the 'Route' Button
    @IBAction func Route(_ sender: UIBarButtonItem) {
        routeIt.Route(sourceCoordinates: myLocation, destination: destination){(error, response, directionRequest) in
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
                var route = response?.routes[0]
                if route?.transportType == .automobile{
                    route?.polyline.title = "Driving Route"
                }
                else if route?.transportType == .transit{
                    route?.polyline.title = "Transit Route"
                }else if route?.transportType == .walking{
                    route?.polyline.title = "Walking Route"
                }
                self.Map.add((route?.polyline)!, level: .aboveRoads)
                var rect = route?.polyline.boundingMapRect
                self.Map.setRegion(MKCoordinateRegionForMapRect(rect!), animated: true)
            }
        }
    }
    
    //what is called when a polyline is added to an MKMapView
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        //set stroke color depending on transport type
        if overlay.title!! == "Driving Route" {
            renderer.strokeColor = UIColor.blue
        }else if overlay.title!! == "Transit Route"{
            renderer.strokeColor = UIColor.yellow
        }else if overlay.title!! == "Walking Route"{
            renderer.strokeColor = UIColor.red
        }
        renderer.lineWidth = 5.0
        
        return renderer
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        OpenNavTab.target = self.revealViewController()
        OpenNavTab.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) //add gesture recognizer to open up the side menu
        
        //set up proper delegates for MKMapView and CLLocationManager
        Map.delegate = self
        Map.showsScale = true
        Map.showsPointsOfInterest = true
        Map.showsUserLocation = true
        
        //request for authorizations
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
        
        
        //set annotations and corresponding coordinates of nearby places to TCNJ
        let paneraAnnotation = MKPointAnnotation()
        let piccoloAnnotation = MKPointAnnotation()
        let dunkinDonutsAnnotation = MKPointAnnotation()
        let trentonFarmersMarketAnnotation = MKPointAnnotation()
        let shopRiteAnnotation = MKPointAnnotation()
        let aldiAnnotation = MKPointAnnotation()
        
        paneraAnnotation.coordinate = CLLocationCoordinate2DMake(40.269408, -74.783281)
        paneraAnnotation.title = "Panera Bread"
        paneraAnnotation.subtitle = "900 Lion Road"
        
        piccoloAnnotation.coordinate = CLLocationCoordinate2DMake(40.268745, -74.783463)
        piccoloAnnotation.title = "Piccolo Pronto"
        piccoloAnnotation.subtitle = "100 Campus Town Circle #101"
        
        trentonFarmersMarketAnnotation.coordinate = CLLocationCoordinate2DMake(40.24380, -74.751213)
        trentonFarmersMarketAnnotation.title = "Trenton Farmers Market"
        trentonFarmersMarketAnnotation.subtitle = "960 Spruce St"
        
        shopRiteAnnotation.coordinate = CLLocationCoordinate2DMake(40.249570, -74.769387)
        shopRiteAnnotation.title = "ShopRite of Ewing"
        shopRiteAnnotation.subtitle = "1750 N Olden Ave"
        
        aldiAnnotation.coordinate = CLLocationCoordinate2DMake(40.246073, -74.761909)
        aldiAnnotation.title = "ALDI"
        aldiAnnotation.subtitle = "1650 N Olden Ave"
        
        dunkinDonutsAnnotation.coordinate = CLLocationCoordinate2DMake(40.276841, -74.781210)
        dunkinDonutsAnnotation.title = "Dunkin' Donuts"
        dunkinDonutsAnnotation.subtitle = "2085 Pennington Rd"
        
        //set up initial display of Map
        myLocation = (manager.location?.coordinate)!
        
        span = MKCoordinateSpanMake(0.02, 0.02)
        region = MKCoordinateRegionMake(myLocation, span)

        Map.setRegion(region, animated: true)
        Map.addAnnotation(paneraAnnotation)
        Map.addAnnotation(piccoloAnnotation)
        Map.addAnnotation(trentonFarmersMarketAnnotation)
        Map.addAnnotation(shopRiteAnnotation)
        Map.addAnnotation(aldiAnnotation)
        Map.addAnnotation(dunkinDonutsAnnotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

