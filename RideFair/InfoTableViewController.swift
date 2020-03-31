//
//  InfoTableViewController.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 3/30/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import Foundation
import UIKit

class InfoTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var infoSearchBar: UISearchBar!
    @IBOutlet var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoSearchBar.delegate = self
        
        tableViewOutlet.keyboardDismissMode = .interactive
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        infoSearchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        infoSearchBar.text = nil
        infoSearchBar.setShowsCancelButton(false, animated: true)
        infoSearchBar.endEditing(true)
    }
    
}
