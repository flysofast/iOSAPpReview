//
//  ViewController.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 8/31/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

  }

  func loadDataFromURL(_ url: String, completion:  @escaping (Data?,NSError?) -> Void) {


    let request = URLRequest(url: URL(string: url)!)

    let session = URLSession.shared

    let loadDataTask = session.dataTask(with:request) { (data, response, error) -> Void in
      if let responseError = error {
        completion(nil, responseError as NSError?)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode != 200 {
          let statusError = NSError(domain:"com.flysofast", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
          completion( nil, statusError)
        } else {
          completion( data as Data?,  nil)
        }
      }
    }

    loadDataTask.resume()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func btTapped(_ sender: AnyObject) {
    let url = "http://itunes.apple.com/rss/customerreviews/id=1128598578/json"
    loadDataFromURL(url) { (data, error) in
      if let data=data{
        
        do {
          let json = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions()) as? [String:AnyObject]

          guard let reviews = RSS(json: json!) else{
            print("Error initializing RSS object")
            return
          }

          guard let firstItem = reviews.feed?.entries?.first else{
            print("No item found")
            return
          }
          print(firstItem)

        } catch {
          print(error)

        }
      }
    }

  }
  
}

