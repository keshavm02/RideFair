//
//  WheelchairViewController.swift
//  RideFair
//
//  Created by Eric Chao on 4/20/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import UIKit

class WheelchairViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.facilitiesList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: facilitiesList[indexPath.row].replacingOccurrences(of: "_", with: " "), message: facilitiesName[indexPath.row], preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        aCell.textLabel?.text = self.facilitiesList[indexPath.row].replacingOccurrences(of: "_", with: " ", options: .literal, range: nil)
        aCell.detailTextLabel?.text = self.facilitiesName[indexPath.row].replacingOccurrences(of: "_", with: " ")
        return aCell
    }
    
    var facilitiesList: [String] = []
    var facilitiesName: [String] = []
    var stopId: String?;
    @IBOutlet weak var wheelchairImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rawFacilitiesList = API().getFacilities(stop: stopId!)
        facilitiesList = Array(rawFacilitiesList.values.map{ $0 })
        facilitiesName = Array(rawFacilitiesList.keys.map{ $0 })
        
        if rawFacilitiesList.isEmpty {
            let noneDict = ["None":"No reported facilities at this stop."]
            facilitiesList = Array(noneDict.keys.map{ $0 })
            facilitiesName = Array(noneDict.values.map{ $0 })
        }
        
        facilitiesTable.rowHeight = 50
        
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var facilitiesTable: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
