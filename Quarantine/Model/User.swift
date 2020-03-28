//
//  User.swift
//  Quarantine
//
//  Created by Chris Tibbs on 3/28/20.
//  Copyright © 2020 Chris Tibbs. All rights reserved.
//

import UIKit
import CoreLocation

class User: ObservableObject {
  enum Pronoun: String {
    case he = "He"
    case she = "She"
    case they = "They"
  }
  
  static let current = User(name: "Chris Tibbs",
                            imageUrl: URL(string: "https://scontent-lga3-1.xx.fbcdn.net/v/t1.0-9/56435185_10113548347774375_7281816076239765504_o.jpg?_nc_cat=109&_nc_sid=09cbfe&_nc_ohc=NdaGU9OybOcAX-fK2A5&_nc_ht=scontent-lga3-1.xx&oh=29bacf6d900167402f0badbe2b9fbf13&oe=5EA66C4F"),
                            dob: Date(),
                            pronoun: "He")
  
  var name: String
  var isActive = false
  var imageUrl: URL?
  var dob: Date
  var pronoun: Pronoun
  @Published var currentLocation: CLLocationCoordinate2D?
  
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
