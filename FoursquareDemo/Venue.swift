//
//  Venue.swift
//  FoursquareDemo
//
//  Created by Mauricio Vasquez on 1/26/16.
//  Copyright © 2016 TestIO. All rights reserved.
//

import Foundation
import RealmSwift

class Venue: Object {
  dynamic var photo = NSData()
  dynamic var title = ""
  dynamic var id = ""
  dynamic var venueDescription = ""
  dynamic var favorite = Bool()
}