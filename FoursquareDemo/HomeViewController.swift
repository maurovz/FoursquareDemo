//
//  HomeViewController.swift
//  FoursquareDemo
//
//  Created by Mauricio Vasquez on 1/26/16.
//  Copyright © 2016 TestIO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet weak var tableView: UITableView!
  var venues : JSON = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getVenues()
  }
  
  // MARK: - TableView DataSource
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return self.venues.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("homeCell") as! HomeTableViewCell
    cell.venueName.text = String(self.venues[indexPath.row]["name"])
    
    return cell
  }
  
  // MARK: - API Call
  
  
  func getVenues() {
    let indicator = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
    indicator.center = self.view.center
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
    view.addSubview(indicator)
    indicator.startAnimating()
    
    Alamofire.request(.GET, "https://api.foursquare.com/v2/venues/search?", parameters: ["ll": "19.411929,-99.178355", "client_id": "WWWCYGJMOHYK4I5J4KALM5SEM4CHN1OWIAHFS4R0I2Z41UUT", "client_secret" : "QVYYDK5ZL0LECH2O2N2G3EFGQSSOOFCZ1ZLDVHV2RMUMVUK3", "v" : "20160120"])
      .responseJSON { response in
        
        if let jsonObject = response.result.value {
          
          let json = JSON(jsonObject)
          self.venues = json["response"]["venues"]
          
          self.tableView.reloadData()
          indicator.stopAnimating()
        }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "venueDetail") {
      let venueDetailViewController = segue.destinationViewController as! VenueDetailViewController
      
      let indexPath = self.tableView.indexPathForSelectedRow
      venueDetailViewController.venueTitle = String(self.venues[indexPath!.row]["name"])
      venueDetailViewController.venueID = String(self.venues[indexPath!.row]["id"])
    }
  }
  
  
}
