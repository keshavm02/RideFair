//
//  MBTA-API.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 4/13/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import Foundation
import UIKit

class API: UIViewController {
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
}
