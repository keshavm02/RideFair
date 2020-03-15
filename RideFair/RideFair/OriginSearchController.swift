//
//  OriginViewController.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 3/14/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class OriginSearchController: UITableViewController {
    
    var resultSearchController:UISearchController? = nil
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        
        let originSearchController = storyboard!.instantiateViewController(withIdentifier: "OriginSearchController") as! OriginSearchController
        resultSearchController = UISearchController(searchResultsController: originSearchController)
        resultSearchController?.searchResultsUpdater = originSearchController
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
}

extension OriginSearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

extension OriginSearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

//    override func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        let selectedItem = matchingItems[indexPath.row].placemark
//        cell.textLabel?.text = selectedItem.name
//        cell.detailTextLabel?.text = ""
//        return cell
//    }
}
