//
//  User.swift
//  Quarantine
//
//  Created by Chris Tibbs on 3/28/20.
//  Copyright © 2020 Chris Tibbs. All rights reserved.
//

import UIKit
import CoreLocation

class User {
  enum Pronoun: String {
    case he = "He"
    case she = "She"
    case they = "They"
  }
  
  static let current = User(name: "Chris Tibbs",
                            dob: Date(),
                            pronoun: "He")
  
  var name: String
  var imageUrl: URL?
  var dob: Date
  var pronoun: Pronoun
  var currentLocation: CLLocationCoordinate2D?
  
  init?(name: String,
        imageUrl: URL? = nil,
        dob: Date,
        pronoun: String,
        currentLocation: CLLocationCoordinate2D? = nil) {
    self.name = name
    self.imageUrl = imageUrl
    self.dob = dob
    
    guard let pronoun = Pronoun(rawValue: pronoun) else {
      print("EQ-3: Invalid value sent to pronoun enum")
      assertionFailure()
      return nil
    }
    self.pronoun = pronoun
    self.currentLocation = currentLocation
  }
}
