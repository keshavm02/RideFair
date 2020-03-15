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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Request and get location
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        //Show current location
        mapView.showsUserLocation = true
        
        // Connect to OriginSearchController
        let originSearchController = storyboard!.instantiateViewController(withIdentifier: "OriginSearchController") as! OriginSearchController
        originSearchController.mapView = mapView

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // Button that zooms into current location
    @IBAction func currentLocationButton(_ sender: Any) {
        let region = MKCoordinateRegion.init(center: mapView.userLocation.coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }

}

