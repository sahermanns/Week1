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
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [[String:AnyObject]] {
      
      var tweets = [Tweet]()
      for tweetObject in rootObject {
        if let text = tweetObject["text"] as? String,
          id = tweetObject["id_str"] as? String,
          userInfo = tweetObject["user"] as? [String : AnyObject],
          userName = userInfo["name"] as? String,
          screenName = userInfo["screen_name"] as? String,
          location = userInfo["location"] as? String,
          profileImageURL = userInfo["profile_image_url"] as? String,
          profileBackgroundImageURL = userInfo["profile_background_image_url"] as? String {
            
            if let retweetedStatus = tweetObject["retweeted_status"] as? [String: AnyObject],
              originalText = retweetedStatus["text"] as? String,
              originalUser = retweetedStatus["user"] as? [String: AnyObject],
              originalUserName = originalUser["name"] as? String {
                
//                the quote stuff will be added below quote, text and user
                
                if let quote = tweetObject["is_quote"] as? [String: AnyObject],
                  originalQuote = quote["text"] as? String,
                  originalQUser = quote["user"] as? [String: AnyObject],
                  originalQUserName = originalQUser["name"] as? String {
                    
                    let tweet = Tweet(text: text, userName: userName, screenName: screenName, location: location, id : id, profileImageURL : profileImageURL, originalText: originalText,  originalUserName: originalUserName, originalQuote: originalQuote, originalQUserName: originalQUserName, profileImage: nil, profileBackgroundImageURL: profileBackgroundImageURL, profileBackgroundImage: nil)
                    tweets.append(tweet)
                    
                }
                
                let tweet = Tweet(text: text, userName: userName, screenName: screenName, location: location, id : id, profileImageURL : profileImageURL, originalText: originalText,  originalUserName: originalUserName, originalQuote: nil, originalQUserName: nil, profileImage: nil, profileBackgroundImageURL: profileBackgroundImageURL, profileBackgroundImage: nil)
                tweets.append(tweet)
                
            } else {
              
              let tweet = Tweet(text: text, userName: userName, screenName: screenName, location: location, id : id, profileImageURL : profileImageURL, originalText: nil, originalUserName: nil, originalQuote: nil, originalQUserName: nil, profileImage: nil, profileBackgroundImageURL: profileBackgroundImageURL, profileBackgroundImage: nil)
              tweets.append(tweet)
            }
        } else {
          //       could not enter loop
        }
        
      }
      return tweets
      
    }
    if let error = error {
    }
    return nil
  }
}
