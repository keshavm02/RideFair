//
//  WheelchairViewController.swift
//  RideFair
//
//  Created by Eric Chao on 4/20/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import UIKit
import Firebase

class WheelchairViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var ratingLabel: UILabel!
    var currentStop = String()
    @IBOutlet weak var rateButton: UIButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.facilitiesList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: facilitiesList[indexPath.row].replacingOccurrences(of: "_", with: " "), message: facilitiesName[indexPath.row], preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
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
    @IBOutlet weak var facilitiesTable: UITableView!

    var stopId: String?;
    @IBOutlet weak var wheelchairImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rateButton.layer.cornerRadius = 15
        
        let rawFacilitiesList = API().getFacilities(stop: stopId!)
        facilitiesList = Array(rawFacilitiesList.values.map{ $0 })
        facilitiesName = Array(rawFacilitiesList.keys.map{ $0 })
        
        if rawFacilitiesList.isEmpty {
            let noneDict = ["None":"No reported facilities at this stop."]
            facilitiesList = Array(noneDict.keys.map{ $0 })
            facilitiesName = Array(noneDict.values.map{ $0 })
        }
        
        facilitiesTable.rowHeight = 50
        facilitiesTable.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getRating()
    }
    
    @IBAction func rateThisStopButtonPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let ratingsVC: RatingsViewController = storyBoard.instantiateViewController(withIdentifier: "rate") as! RatingsViewController
        ratingsVC.modalPresentationStyle = .popover
        
        ratingsVC.stopName = currentStop
            
        self.present(ratingsVC, animated:true, completion:nil)
        
        ratingsVC.topLabel.text = "Please rate \(currentStop) out of 5."
    }
    
    func getRating() {
        
        self.showSpinner(onView: self.view)
        let docRef = db.collection("ratings").document(currentStop)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.removeSpinner()
                
                let documentData = document.data()
                
                self.ratingLabel.text = "Rated \(documentData?["rating"] ?? "0")/5"
                print("Document data: \(documentData)")
            } else {
                self.removeSpinner()
                
                print("Document does not exist")
            }
        }
        
    }
    
}
