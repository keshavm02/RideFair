//
//  RatingsViewController.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 4/25/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import Foundation
import UIKit

class RatingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var commentsField: UITextView!
    
    var pickerData: [Int] = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        pickerData = [1, 2, 3, 4, 5]
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> Int? {
        return pickerData[row]
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let rating = pickerData[pickerView.selectedRow(inComponent: 0)]
        
    }
}
