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
    
    
    @IBAction func Route(_ sender: Any) {
        
    }
    
    let manager = CLLocationManager()
    private let reuseIdentifier = "MyIdentifier"
    
    //annotation view customization
    func mapView(mapView: MKMapView, viewFor annotation:MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {return nil}
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else { annotationView?.annotation = annotation }
        
        return annotationView
    }
    
    //what happens when the user selects and deselects an annotation
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if !(annotation is MKUserLocation){
            BtnRoute.isEnabled = true
        }
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        BtnRoute.isEnabled = false
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
        let myLocation = manager.location?.coordinate //get users current location coordinates
        
        var span = MKCoordinateSpanMake(0.02, 0.02)
        var region = MKCoordinateRegionMake(myLocation!, span)
        
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

