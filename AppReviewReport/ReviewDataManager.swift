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
  private let countryCodes: [String] = ["AE","AG","AI","AL","AM","AO","AR","AT","AU","AZ","BB","BE","BF","BG","BH","BJ","BM","BN","BO","BR","BS","BT","BW","BY","BZ","CA","CG","CH","CL","CN","CO","CR","CV","CY","CZ","DE","DK","DM","DO","DZ","EC","EE","EG","ES","FI","FJ","FM","FR","GB","GD","GH","GM","GR","GT","GW","GY","HK","HN","HR","HU","ID","IE","IL","IN","IS","IT","JM","JO","JP","KE","KG","KH","KN","KR","KW","KY","KZ","LA","LB","LC","LK","LR","LT","LU","LV","MD","MG","MK","ML","MN","MO","MR","MS","MT","MU","MW","MX","MY","MZ","NA","NE","NG","NI","NL","NO","NP","NZ","OM","PA","PE","PG","PH","PK","PL","PT","PW","PY","QA","RO","RU","SA","SB","SC","SE","SG","SI","SK","SL","SN","SR","ST","SV","SZ","TC","TD","TH","TJ","TM","TN","TR","TT","TW","TZ","UA","UG","US","UY","UZ","VC","VE","VG","VN","YE","ZA","ZW"]

  private var availableCountryCodes: [String]

  override init() {
    availableCountryCodes = self.countryCodes
  }

// MARK: REVIEW DATA
  func refreshData(){
    reviewData = [:]
    availableCountryCodes = countryCodes
    delegate?.dataUpdated(forCountryCode: countryCodes[0], newData: nil)

  }
  func getReviewsFor(countryCode: String, index: Int) -> Review {
     let reviews = getReviewsFrom(countryCode: countryCode)
      if(reviews.count > index){
        return reviews[index]!

    }
      else{
        return Review()
    }
  }

 private func getReviewsFrom(countryCode: String) -> [Review?]{

   let reviews = reviewData[countryCode]
    if(reviews == nil || reviews?.count==0){
      let a:Review = Review()
      reviewData[countryCode] = [a]

      ReviewRetriever.getReviewsFrom(AppID: appIDArray[selectedAppIndex], Country: countryCode) { (list) in
        if( list != nil && (list?.count)! > 0){

          self.reviewData[countryCode] = list


        }else{

          if let deletedIndex = self.availableCountryCodes.index(of: countryCode){

            self.availableCountryCodes.remove(at: deletedIndex)
          }

        }
        self.delegate?.dataUpdated(forCountryCode: countryCode, newData: list)
      }


    }

    return reviewData[countryCode]!

  }

  //MARK: Country names - Country Codes

  func getCountryNameWith(code: String) -> String{

    //for code in NSLocale.isoCountryCodes as [String] {
    let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
    let name = NSLocale(localeIdentifier: Locale.current.identifier).displayName(forKey: NSLocale.Key.identifier, value: id) ?? code

    return name
  }

  func getCountryNameWith(index: Int) -> String{
    if(index < availableCountryCodes.count){
      return getCountryNameWith(code: availableCountryCodes[index])
    }
    else{
      return "No review data"
    }
  }

  func getAvailableCountryWith(index: Int) ->String{
    if(index < availableCountryCodes.count){
      return  availableCountryCodes[index]
    }
    else{
      return ""
    }

  }

  func getAvailableCountryCodes() -> [String]{
    return availableCountryCodes
  }

}
