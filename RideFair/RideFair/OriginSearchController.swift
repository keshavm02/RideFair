//
//  OriginViewController.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 3/14/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import Foundation
import UIKit

class OriginSearchController: UITableViewController {
    
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "OriginSearchController") as! OriginSearchController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
    }
}

extension OriginSearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    }
}
