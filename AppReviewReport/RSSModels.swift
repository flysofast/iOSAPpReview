//
//  ReviewRSS.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 9/1/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit

public struct RSS: Decodable {
  public let feed: Feed?
  public init?(json:JSON){
    feed="feed" <~~ json
  }
}

public struct Feed: Decodable{
  public let entries:[Review]?
  public init?(json:JSON){
    entries="entry" <~~ json
  }
}

public struct Review: Decodable{
  public let ratingStars:Int
  public let author:String
  public let version:String
  public let title:String
  public let content:String
  public init?(json:JSON){

    guard let authorCont: JSON = "author" <~~ json,
      let authorNameCont: JSON = "name" <~~ authorCont,
      let versionCont: JSON = "im:version" <~~ json,
      let ratingCont: JSON = "im:rating" <~~ json,
      let titleCont: JSON = "title" <~~ json,
      let contentCont: JSON = "content" <~~ json

      else {return nil  }

    guard let author: String = "label" <~~ authorNameCont,
      let version: String = "label" <~~ versionCont,
      let rating: String = "label" <~~ ratingCont,
      let title: String = "label" <~~ titleCont,
      let content: String = "label" <~~ contentCont
      else {return nil}

    self.author=author
    self.content=content
    self.version=version
    self.ratingStars = Int(rating)!
    self.title=title
    
    
  }
  
}
