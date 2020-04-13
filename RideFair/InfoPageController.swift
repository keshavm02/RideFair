//
//  InfoPageController.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 4/12/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import Foundation
import UIKit

class InfoPageController: UIViewController {
    
    let infoTableVC = InfoTableViewController()
    
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
                                     "Boston College": "place-lake"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
