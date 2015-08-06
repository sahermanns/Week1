//
//  TweetDetailViewController.swift
//  Sarah's Twitter
//
//  Created by Sarah Hermanns on 8/5/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UINavigationControllerDelegate  {

  @IBOutlet weak var tweetDetailImage: UIButton!
  
  @IBOutlet weak var tweetDetailUserName: UILabel!
  
  @IBOutlet weak var tweetDetailText: UILabel!
  
  @IBOutlet weak var retweetOriginalUserName: UILabel!
  
  @IBOutlet weak var retweetOriginalText: UILabel!
  
  @IBOutlet weak var quoteOriginalUserName: UILabel!
  
  @IBOutlet weak var quoteOriginalText: UILabel!
  
  var selectedTweet = Tweet(text: "blahhh", userName: "Dum", id: "383838", profileImageURL: "lookatme", originalText: "Dummer", originalUserName: "blahblah", originalQuote: "shut up", originalQUserName: "dummerer")
  
//  let tweet = Tweet(text: text, userName: userName, id : id, profileImageURL : profileImageURL)

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
    }
    

}
