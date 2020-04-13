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
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedStop = infoTableVC.selectedStop
        let stopCode = stopIDs[selectedStop] ?? "place-lech"
        if (isWheelChairAccessible(stop: stopCode) == 1) {
            image.image = UIImage(named: "wheelchair")
        }
    }
    
    func getFacilities(stop: String) -> [String: String]{
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://api-v3.mbta.com/facilities?filter[stop]="+stop)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        var facil: [String: String] = [:]
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []){
              if let jsonArray = responseJSON as? [String: Any]{
                  if let dat = jsonArray["data"] as? [[String: Any]]{
                      for fac in dat{
                        if let attributes = fac["attributes"] as? [String: Any]{
                            //type specifies what type of facility it is
                            if let curFac = attributes["type"] as? String{
                                //short name identifies the specific facility
                                if let name = attributes["short_name"] as? String{
                                    facil[name] = curFac
                                }
                            }
                        }
                      }
                  }
              }
          }
          semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        //return a dictionary with the short_name of the facility as key, and they type of facility as value
        return facil
    }

    //function that finds whether a stop is wheelchair accessible given a stop id as parameter
    //returns 1 if the stop is accessible, or 2 if it is not accessible
    func isWheelChairAccessible(stop: String) -> Int{
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://api-v3.mbta.com/stops/"+stop+"/")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        var isAccessible = 2
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []){
              if let jsonArray = responseJSON as? [String: Any]{
                  if let dat = jsonArray["data"] as? [String: Any]{
                      if let attributes = dat["attributes"] as? [String: Any]{
                          if let accessible = attributes["wheelchair_boarding"] as? Int{
                              isAccessible = accessible
                          }
                      }
                  }
              }
          }
          semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return isAccessible
    }
    
}
