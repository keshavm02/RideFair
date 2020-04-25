//
//  RatingsViewController.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 4/25/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RatingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var commentsField: UITextView!
    
    var stopName = String()
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        pickerData = ["1", "2", "3", "4", "5"]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let rating = pickerData[pickerView.selectedRow(inComponent: 0)]
        
        if commentsField.text != nil {
            db.collection("ratings").document(stopName).setData([
                "rating": rating,
                "comments": commentsField.text
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    
                    let alert = UIAlertController(title: "Success", message: "Your rating has been recorded!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                        if let nav = self.navigationController {
                            nav.popViewController(animated: true)
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }))
                    self.present(alert, animated: true)
                }
            }
        } else {
            db.collection("ratings").document(stopName).setData([
                "rating": rating
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    
                    let alert = UIAlertController(title: "Success", message: "Your rating has been recorded!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                        if let nav = self.navigationController {
                            nav.popViewController(animated: true)
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
