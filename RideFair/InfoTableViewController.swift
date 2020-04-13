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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var selectedStop = String()
    
    let stops: [String] = ["Lechmere",
                           "Science Park/West End",
                           "North Station",
                           "Haymarket",
                           "Government Center",
                           "Park Street",
                           "Boylston",
                           "Arlington",
                           "Copley",
                           "Hynes Convention Center",
                           "Kenmore",
                           "Blandford Street",
                           "BU East",
                           "BU Central",
                           "BU West",
                           "St Paul Street",
                           "Pleasant Street",
                           "Babcock Street",
                           "Packard's Corner",
                           "Harvard Ave",
                           "Griggs Street",
                           "Allston Street",
                           "Warren Street",
                           "Washington Street",
                           "Sutherland Road",
                           "Chiswick Road",
                           "Chestnut Hill Ave",
                           "South Street",
                           "Boston College"]
    
    let cellReuseIdentifier = "cell"
    
    var filteredStops: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 50
        
        searchBar.delegate = self
        filteredStops = stops
        
        tableView.keyboardDismissMode = .interactive
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        self.tabBarController?.navigationItem.title = "Stops"
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredStops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        cell.textLabel?.text = self.filteredStops[indexPath.row]
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredStops = searchText.isEmpty ? stops : stops.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        selectedStop = stops[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "InfoPageController") as! InfoPageController
        nextViewController.modalPresentationStyle = .popover
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
        searchBar.tintColor = UIColor.blue
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        filteredStops = stops
        tableView.reloadData()
    }
}
