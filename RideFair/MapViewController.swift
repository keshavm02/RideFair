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
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var mapBar: UITabBarItem!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var startNavigationButton: NavigationButton!
    @IBOutlet weak var fromClearButton: UIButton!
    @IBOutlet weak var toClearButton: UIButton!
    
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        mapView.showsUserLocation = true // Show current location
        
        // Request and get location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }
        
    // When user selects address, drop red pin and zoom in on that location
    func dropPinZoomIn(long: Double, lat: Double, name: String, address: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.title = name
        annotation.subtitle = address
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    // Draw route between origin and destination on map
    func drawRouteOnMap(originCoord: CLLocationCoordinate2D, destCoord: CLLocationCoordinate2D) {
        mapView.removeAnnotations(mapView.annotations)
        let sourcePlacemark = MKPlacemark(coordinate: originCoord)
        let destPlacemark = MKPlacemark(coordinate: destCoord)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destMapItem = MKMapItem(placemark: destPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Start: Warren Towers"
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destAnnotation = MKPointAnnotation()
        destAnnotation.title = "End: Boston Public Library"
        if let location = destPlacemark.location {
            destAnnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnnotation,destAnnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destMapItem
        directionRequest.transportType = .automobile
        
        // Calculate direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            var regionRect = route.polyline.boundingMapRect
            
            // Add padding to the viewable region of entire route
            let wPadding = regionRect.size.width * 0.5
            let hPadding = regionRect.size.height * 0.5
            regionRect.size.width += wPadding
            regionRect.size.height += hPadding

            // Center the region on the line
            regionRect.origin.x -= wPadding / 2
            regionRect.origin.y -= hPadding / 2
            
            self.mapView.setRegion(MKCoordinateRegion(regionRect), animated: true)
        }
    }
    
    // Render blue route line between origin and destination
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        renderer.lineWidth = 5.0

        return renderer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        locationManager.startUpdatingLocation()
    }
    
    // Pass search bar input values to next View Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "maptoFromSegue" {
            let vc = segue.destination as! FromTableViewController
            vc.origin = fromTextField.text ?? ""
        }
        
        if segue.identifier == "maptoToSegue" {
            let vc = segue.destination as! ToTableViewController
            vc.dest = toTextField.text ?? ""
        }
    }
    
    // Button that zooms into current location
    @IBAction func currentLocationButton(_ sender: Any) {
        /*locationButton.layer.cornerRadius = 5
         locationButton.layer.borderWidth = 1
         locationButton.layer.borderColor = UIColor.blue.cgColor*/
        let region = MKCoordinateRegion.init(center: mapView.userLocation.coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    // Zoom into current location when app loads
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
    }
    
    // When user types in "From" text field, open location search table view
    @IBAction func fromTextFieldChanged(_ sender: Any) {
        performSegue(withIdentifier: "maptoFromSegue", sender: nil)
    }
    
    @IBAction func toTextFieldChanged(_ sender: Any) {
        performSegue(withIdentifier: "maptoToSegue", sender: nil)
    }
    
    // Clear button for "From" text field
    @IBAction func fromClearButtonClicked(_ sender: Any) {
        fromTextField.text = ""
        fromTextField.placeholder = "Enter origin"
    }
    
    // Clear button for "To" text field
    @IBAction func toClearButtonClicked(_ sender: Any) {
        toTextField.text = ""
        toTextField.placeholder = "Enter destination"
    }
    
    // Return to main map view from another View Controller
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        print("Unwind to Root View Controller")
    }
}
