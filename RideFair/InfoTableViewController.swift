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
    
    let stopIDs: [String: String] = ["Lechmere": "place-lech",
                                     "Science Park/West End": "place-spmnl",
                                     "North Station": "place-north",
                                     "Haymarket": "place-haecl",
                                     "Government Center": "place-gover",
                                     "Park Street": "place-pktrm",
                                     "Boylston": "place-boyls",
                                     "Arlington": "place-armnl",
                                     "Copley": "place-coecl",
                                     "Hynes Convention Center": "place-hymnl",
                                     "Kenmore": "place-kencl",
                                     "Blandford Street": "place-bland",
                                     "BU East": "place-buest",
                                     "BU Central": "place-bucen",
                                     "BU West": "place-buwst",
                                     "St Paul Street": "place-stplb",
                                     "Pleasant Street": "place-plsgr",
                                     "Babcock Street": "place-babck",
                                     "Packard's Corner": "place-brico",
                                     "Harvard Ave": "place-harvd",
                                     "Griggs Street": "place-grigg",
                                     "Allston Street": "place-alsgr",
                                     "Warren Street": "place-wrnst",
                                     "Washington Street": "place-wascm",
                                     "Sutherland Road": "place-sthld",
                                     "Chiswick Road": "place-chswk",
                                     "Chestnut Hill Ave": "place-chill",
                                     "South Street": "place-sougr",
                                     "Boston College": "place-lake",]
    

    let cellReuseIdentifier = "cell"
    
    var filteredStops: [String]!
    
    var selectedStop: String = "";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 70
        
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
        
        selectedStop = filteredStops[indexPath.row]
        print(selectedStop)
        let stopCode = stopIDs[selectedStop] ?? "place-lech"
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let isWheelchairAccessible = API().isWheelChairAccessible(stop: stopCode)
        if (isWheelchairAccessible == 1) {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "wheelchair") as! WheelchairViewController
            nextViewController.modalPresentationStyle = .popover
            nextViewController.stopId = stopCode
            self.present(nextViewController, animated:true, completion:nil)
        } else if (isWheelchairAccessible == 2) {
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "wheelchair") as! WheelchairViewController
            nextViewController.modalPresentationStyle = .popover
            nextViewController.stopId = stopCode
            self.present(nextViewController, animated:true, completion:nil)
            nextViewController.wheelchairImageView.image = UIImage(named: "notWheelchair")
        }
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
