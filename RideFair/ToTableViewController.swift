//
//  ToTableViewController.swift
//  RideFair
//
//  Created by Ivy Chenyao on 4/19/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import UIKit
import MapKit

class ToTableViewController: UITableViewController {
    @IBOutlet weak var destSearchBar: UITextField!
    var dest = String()
    var numberOfRowsAtSection: [Int] = [2,0]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        destSearchBar.text = dest
        destSearchBar.becomeFirstResponder() // Allow user to start typing as soon as this table view opens
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        if section < numberOfRowsAtSection.count {
            rows = numberOfRowsAtSection[section]
        }
        return rows
    }
    
    @IBAction func destSearchChanged(_ sender: Any) {
        if destSearchBar.text == "Bost" {
            numberOfRowsAtSection[1] = 6
            
            // Slight delay for results to show
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
               self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegue2" {
            let vc = segue.destination as! MapViewController
            vc.toTextField.text = "Boston Public Library"
            vc.dropPinZoomIn(long: -71.078369,lat: 42.349396,name: "Boston Public Library",address:"700 Boylston St, Boston, MA 02116")
            
            let origCoord = CLLocationCoordinate2D(latitude: 42.3495, longitude: -71.1048)
            let desCoord = CLLocationCoordinate2D(latitude: 42.349396, longitude: -71.078369)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                vc.drawRouteOnMap(originCoord: origCoord, destCoord: desCoord)
            }
        }
    }
}
