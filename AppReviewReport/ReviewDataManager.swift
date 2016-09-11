//
//  ReviewDataManager.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 9/6/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit
protocol ReviewDataManagerDelegate: class{
  func dataUpdated(forCountryCode: String, newData: [Review?]?)
}
class ReviewDataManager: NSObject {

  var reviews:[Review]?
//  var selectedCountryCode = "US"
  var selectedAppIndex = 0
  var appIDArray = ["1128598578","920659520"]
  var appArray = ["Night club strobe light","Scan & translate"]
  weak var delegate : ReviewDataManagerDelegate?
  public var reviewData : Dictionary<String, Array<Review?>> = [:]


  var availableCountryCode: [String]

  override init() {
    availableCountryCode = NSLocale.isoCountryCodes
  }

  func addReviewWith(countryCode: String, review: Review){
    reviewData[countryCode]?.append(review)

  }

  func addReviewWith(countryCode: String, reviews: [Review?]){
    reviewData[countryCode]?.append(contentsOf: reviews)
  }

  func getReviewsFrom(countryCode: String) -> [Review?]{

   let reviews = reviewData[countryCode]
    if(reviews == nil || reviews?.count==0){
      let a:Review = Review()
      reviewData[countryCode] = [a]

      ReviewRetriever.getReviewsFrom(AppID: appIDArray[selectedAppIndex], Country: countryCode) { (list) in
        if( list != nil && (list?.count)! > 0){

          self.reviewData[countryCode] = list


        }else{

          self.availableCountryCode.remove(at: self.availableCountryCode.index(of: countryCode)!)

        }
        self.delegate?.dataUpdated(forCountryCode: countryCode, newData: list)
      }


    }

    return reviewData[countryCode]!

  }

  func getCountryNameWith(code: String) -> String{

    //for code in NSLocale.isoCountryCodes as [String] {
    let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
    let name = NSLocale(localeIdentifier: Locale.current.identifier).displayName(forKey: NSLocale.Key.identifier, value: id) ?? code

    return name
  }

}
