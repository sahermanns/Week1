//
//  TweetJSONParser.swift
//  Sarah's Twitter
//
//  Created by Sarah Hermanns on 8/3/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import Foundation

class TweetJSONParser {
  class func tweetsFromJSONData(jsonData: NSData) -> [Tweet]? {
    
    var error : NSError?
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as?
      [[String:AnyObject]]
      
    {
      var tweets = [Tweet]()
      for tweetObject in rootObject {
        if let text = tweetObject["text"] as? String,
          id = tweetObject["id_str"] as? String,
          userInfo = tweetObject["user"] as? [String : AnyObject],
          userName = userInfo["name"] as? String,
          profileImageURL = userInfo["profile_image_url"] as? String {
            let tweet = Tweet(text: text, userName: userName, id : id, profileImageURL : profileImageURL)
            tweets.append(tweet)
        } else {
          
        }
        
      }
      return tweets
      
    }
    if let error = error {
    }
    return nil
  }
}
