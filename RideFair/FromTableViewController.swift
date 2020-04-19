//
//  FromTableViewController.swift
//  RideFair
//
//  Created by Ivy Chenyao on 4/18/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import UIKit

class FromTableViewController: UITableViewController {
    @IBOutlet weak var originSearchBar: UITextField!
    var origin = String()
    var numberOfRowsAtSection: [Int] = [2, 0]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        originSearchBar.text = origin // Pull input text from Map search bar
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // Set number of cells in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        // 1st section contains search bar and Current Location option = 2 cells
        // 2nd section contains hard-coded search results = 6 cells
        if section < numberOfRowsAtSection.count {
            rows = numberOfRowsAtSection[section]
        }
        
        return rows
    }
    
    @IBAction func originSearchChanged(_ sender: Any) {
        // Show search results
        if originSearchBar.text == "War" {
            numberOfRowsAtSection[1] = 6
            
            // Slight delay for results to show
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
               self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegue" {
            let vc = segue.destination as! MapViewController
            vc.fromTextField.text = "Warren Towers"
            vc.dropPinZoomIn(long: -71.1048,lat: 42.3495,name: "Warren Towers",address:"700 Commonwealth Avenue, Boston, MA 02215")
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        
        if indexPath.row == 4 {
            cell.isHidden = true
        }
        else {
            cell.isHidden = false
        }
        
        return cell
    }
    */
    
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight: CGFloat = 0.0
        if(indexPath.row == 4) {
            rowHeight = 0.0
        }
        else {
            rowHeight = 87.0
        }
        return rowHeight
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
