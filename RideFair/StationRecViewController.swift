//
//  StationRecViewController.swift
//  RideFair
//
//  Created by Ivy Chenyao on 4/19/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import UIKit
import MapKit

class StationRecViewController: UIViewController {
    @IBOutlet weak var handicapSwitch: UISwitch!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var recView: UIView!
    @IBOutlet weak var nonhandicapRecView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // After green "Go" button is clicked, message pops up to open a navigation app
    @IBAction func goClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Ready to navigate?", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        // Open Apple Maps transit view with chosen start & end locations
        alert.addAction(UIAlertAction(title: "Open Maps", style: UIAlertAction.Style.default, handler: { action in
            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.349, longitude: -71.1048)))
            source.name = "Warren Towers"

            let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.3495, longitude: -71.078369)))
            destination.name = "Boston Public Library"
            MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeTransit])
        }))
        
        alert.addAction(UIAlertAction(title: "Open Google Maps", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Open Waze", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Toggle switch to indicate handicap accessibility stations required
    @IBAction func handicapSwitchToggled(_ sender: Any) {
        // Add slight delay to load
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if self.handicapSwitch.isOn == true { // Show handicap accessible only stations
                self.recView.isHidden = false
                self.nonhandicapRecView.isHidden = true
            } else { // Show all recommended stations
                self.recView.isHidden = true
                self.nonhandicapRecView.isHidden = false
            }
        }
    }
}
