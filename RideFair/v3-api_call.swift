#!/usr/bin/env swift
import Foundation

var semaphore = DispatchSemaphore (value: 0)

var request = URLRequest(url: URL(string: "https://api-v3.mbta.com/stops/place-kencl/")!,timeoutInterval: Double.infinity)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in 
  guard let data = data else {
    print(String(describing: error))
    return
  }
  if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []){
      if let jsonArray = responseJSON as? [String: Any]{
          if let dat = jsonArray["data"] as? [String: Any]{
              if let attributes = dat["attributes"] as? [String: Any]{
                  print(attributes["wheelchair_boarding"])
              }
          }
      }
  }
  //print(String(data: data, encoding: .utf8)!)
  semaphore.signal()
}

task.resume()
semaphore.wait()
