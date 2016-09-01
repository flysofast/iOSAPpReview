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

  public func loadDataFromURL(url: String, completion:  @escaping (NSData?,NSError?) -> Void) {


    let request = URLRequest(url: URL(string: url)!)

    let session = URLSession.shared

    let loadDataTask = session.dataTask(with:request) { (data, response, error) -> Void in
      if let responseError = error {
        completion(nil, responseError as NSError?)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode != 200 {
          let statusError = NSError(domain:"com.raywenderlich", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
          completion( nil, statusError)
        } else {
          completion( data as NSData?,  nil)
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
    loadDataFromURL(url: url) { (data, error) in
      print(String.init(data: data as! Data, encoding: .utf8))
    }

  }
  
}

