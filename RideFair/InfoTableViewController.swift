//
//  InfoTableViewController.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 3/30/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import Foundation
import UIKit

class InfoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var infoSearchBar: UISearchBar!
    @IBOutlet var tableViewOutlet: UITableView!
    
    let documents: [String] = ["Criminal Complaint Form", "Criminal Complaint Application", "Police Report", "Booking Photo", "Miranda Form", "Board of Probation Criminal Record"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        
        infoSearchBar.delegate = self
        
        tableViewOutlet.keyboardDismissMode = .interactive
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        infoSearchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        infoSearchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        infoSearchBar.text = nil
        infoSearchBar.setShowsCancelButton(false, animated: true)
        infoSearchBar.endEditing(true)
    }
    
}
