//
//  TwitterService.swift
//  Sarah's Twitter
//
//  Created by Sarah Hermanns on 8/4/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
  
  static let sharedService = TwitterService()
  
  var account: ACAccount?
  
  private init() {}
  


  class func tweetsFromHomeTimeline(completionHandler : (String?, [Tweet]?) -> (Void)) {
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL (string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!, parameters: nil)
      request.account = self.sharedService.account
    
    request.performRequestWithHandler { (data, response, error) -> Void in
      if let error = error {
        completionHandler("could not connect to the server", nil)
      } else {
        println(response.statusCode)
        switch response.statusCode {
          case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          completionHandler(nil, tweets)
          case 400...499:
          completionHandler("There was an error on the client side", nil)
          case 500...599:
          completionHandler("There was an error on the server side, try again later", nil)
          default:
          completionHandler("There was an unknown error", nil)
        }
      }
    }
  }
  
  class func tweetsFromUserTimeline(username: String, completionHandler : (String?, [Tweet]?) -> (Void)) {
    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL (string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(username)")!, parameters: nil)
      request.account = self.sharedService.account
  
      request.performRequestWithHandler { (data, response, error) -> Void in
        if let error = error {
          completionHandler("could not connect to the server", nil)
        } else {
          println(response.statusCode)
        switch response.statusCode {
          case 200...299:
          let tweets = TweetJSONParser.tweetsFromJSONData(data)
          completionHandler(nil, tweets)
          case 400...499:
          completionHandler("There was an error on the client side", nil)
          case 500...599:
          completionHandler("There was an error on the server side, try again later", nil)
          default:
          completionHandler("There was an unknown error", nil)
        }
      }
  
    }
  }
}
