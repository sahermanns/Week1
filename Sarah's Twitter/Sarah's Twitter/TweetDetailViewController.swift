//
//  TweetDetailViewController.swift
//  Sarah's Twitter
//
//  Created by Sarah Hermanns on 8/5/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

// Issue with this view controller is that selectedTweet is gone or not connected to what is needs to have ...help?!!

import UIKit

class TweetDetailViewController: UIViewController, UINavigationControllerDelegate  {


  @IBOutlet weak var tweetDetailImage: UIButton!
  
  @IBOutlet weak var tweetDetailUserName: UILabel!
  
  @IBOutlet weak var tweetDetailText: UILabel!
  
  @IBOutlet weak var retweetOriginalUserName: UILabel!
  
  @IBOutlet weak var retweetOriginalText: UILabel!
  
  @IBOutlet weak var quoteOriginalUserName: UILabel!
  
  @IBOutlet weak var quoteOriginalText: UILabel!
  
  var selectedTweet = Tweet(text: "blahhh", userName: "Dum", screenName: "dork", location: "nowhere", id: "383838", profileImageURL: "lookatme", originalText: "Dummer", originalUserName: "blahblah", originalQuote: "shut up", originalQUserName: "dummerer", profileImage: nil, profileBackgroundImageURL: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
      
      title = self.selectedTweet.userName
      tweetDetailUserName.text = self.selectedTweet.userName
      tweetDetailText.text = self.selectedTweet.text
//      tweetDetailImage.image = self.selectedTweet.profileImageURL
      retweetOriginalText.text = self.selectedTweet.originalText
      retweetOriginalUserName.text = self.selectedTweet.originalUserName
      quoteOriginalUserName.text = self.selectedTweet.originalQUserName
      quoteOriginalText.text = self.selectedTweet.originalQuote
  }
    
      override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showUser" {
//          if let button = sender as? UIButton {
//            
//          }
          let destinationVC = segue.destinationViewController as! userTimelineViewController
          destinationVC.selectedTweet = selectedTweet
    
        }
        
    }

}
