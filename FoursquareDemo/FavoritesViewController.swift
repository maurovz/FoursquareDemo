//
//  FavoritesViewController.swift
//  FoursquareDemo
//
//  Created by Mauricio Vasquez on 1/27/16.
//  Copyright © 2016 TestIO. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var venue = Venue()
  var venues = []
  let realm = try! Realm()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    loadFavorites()
  }
  
  // MARK: - TableView DataSource
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("homeCell") as! HomeTableViewCell
    cell.venueName.text = self.venues[indexPath.row].title
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.venues.count
  }
  
  // MARK: - Load Realm
  
  
  func loadFavorites() {
    
    let results = self.realm.objects(Venue)
    self.venues = Array(results)
    self.tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "favoriteVenueDetail") {
      let venueDetailViewController = segue.destinationViewController as! FavoriteDetailViewController
      
      let indexPath = self.tableView.indexPathForSelectedRow
      
      if let indexPath = indexPath?.row {
        let venue : Venue = self.venues[indexPath] as! Venue
        let title = venue.title as String!
        let description = venue.venueDescription as String!
        
        venueDetailViewController.venueTitle = title
        venueDetailViewController.venueDescription = description
        venueDetailViewController.venueImageData = venue.photo
      }
    }
  }
  
}
