//
//  FromTableViewController.swift
//  RideFair
//
//  Created by Ivy Chenyao on 4/18/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import UIKit

class FromTableViewController: UITableViewController {
    @IBOutlet weak var originSearchBar: UITextField!
    var origin = String()
    var numberOfRowsAtSection: [Int] = [2,0]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false // Preserve selection between presentations
        originSearchBar.text = origin // Pull input text from Map search bar
        originSearchBar.becomeFirstResponder() // Allow user to start typing as soon as this table view opens
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // Set number of cells in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        // 1st section contains search bar and Current Location option = 2 cells
        // 2nd section contains hard-coded search results = 6 cells
        if section < numberOfRowsAtSection.count {
            rows = numberOfRowsAtSection[section]
        }
        return rows
    }
    
    @IBAction func originSearchChanged(_ sender: Any) {
        // Show search results
        if originSearchBar.text == "War" {
            numberOfRowsAtSection[1] = 6
            
            // Slight delay for results to show
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
               self.tableView.reloadData()
            }
        }
    }
    
    // Go back to map view and drop pin on selected location
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegue" {
            let vc = segue.destination as! MapViewController
            vc.fromTextField.text = "Warren Towers"
            vc.dropPinZoomIn(long: -71.1048,lat: 42.3495,name: "Warren Towers",address:"700 Commonwealth Avenue, Boston, MA 02215")
        }
    }
}
