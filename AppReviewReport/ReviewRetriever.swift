//
//  ReviewRetriver.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 9/1/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit

class ReviewRetriever: NSObject {
  class func loadDataFromURL(_ url: String, completion:  @escaping (Data?,NSError?) -> Void) -> Void {

    if (url == ""){
      return
    }

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

  class func getReviewsFrom(AppID: String, Country: String, completion: @escaping ([Review]?) -> Void ){
    let url = "http://itunes.apple.com/\(Country)/rss/customerreviews/id=\(AppID)/sortBy=mostRecent/json"
    loadDataFromURL(url) { (data, error) in
      if let data=data{

        do {
          let json = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions()) as? [String:AnyObject]

          guard let reviews = RSS(json: json!) else{
            print("\(Country) ReviewRetriever: Error initializing RSS object")
             completion(nil)
            return
          }

          guard let items = reviews.feed?.entries else{
            print("\(Country) ReviewRetriever: No item found")
             completion(nil)
            return
          }

          completion(items)

        } catch {
          print(error)

          completion(nil)
          
        }
      }
    }
  }

}
