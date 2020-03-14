//
//  ViewController.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 2/26/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Request and get location
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        //Show current location
        mapView.showsUserLocation = true
        
        let request = MKDirections.Request()
        request.transportType = .transit
    }


}

