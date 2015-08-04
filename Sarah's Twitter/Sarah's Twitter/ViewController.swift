//
//  ViewController.swift
//  Sarah's Twitter
//
//  Created by Sarah Hermanns on 8/3/15.
//  Copyright (c) 2015 SASH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var tweets = [Tweet]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    if let filepath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json"){
      if let data = NSData(contentsOfFile: filepath) {
        if let tweets = TweetJSONParser.tweetsFromJSONData(data) {
          self.tweets = tweets
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}


//keeping tableview control separate from main view control

extension ViewController : UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! UITableViewCell
    let tweet = tweets[indexPath.row]
    cell.textLabel?.text = tweet.text
    
    return cell
  }
}


