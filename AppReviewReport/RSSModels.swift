//
//  ReviewRSS.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 9/1/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit

public struct RSS: Decodable {
  public var feed: Feed?
  public init?(json:JSON){
    feed="feed" <~~ json
  }
}

public struct Feed: Decodable{
  public var entries:[Review]?
  public init?(json:JSON){
    entries="entry" <~~ json
  }
}

public struct AppInfo: Decodable{
  public var appName:String
  public var rights: String
  public var author: String

  public init?(json:JSON){
  guard let authorCont: JSON = "im:artist" <~~ json,
    let rightsCont: JSON = "rights" <~~ json,
    let appNameCont: JSON = "title" <~~ json
    else{
      return nil
    }

    guard let appName: String = "label" <~~ appNameCont,
      let author: String = "label" <~~ authorCont,
      let rights: String = "label" <~~ rightsCont
      else{
        return nil
    }

    self.author=author
    self.appName=appName
    self.rights=rights
  }
}

public struct Review: Decodable{
  public var ratingStars:Int
  public var author:String
  public var version:String
  public var title:String
  public var content:String
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

  public init(){
    ratingStars = 1;
    author = "Loading..."
    version = "Loading..."
    title = "Loading..."
    content = "Loading..."
  }
  
}
