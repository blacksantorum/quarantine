//
//  NetworkManager.swift
//  Quarantine
//
//  Created by Chris Tibbs on 3/28/20.
//  Copyright © 2020 Chris Tibbs. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseFirestore

protocol NetworkManagerDelegate: AnyObject {
  func registeredUserActive(_ user: User)
}

class NetworkManager: NSObject, LocationDelegate {
  weak var delegate: NetworkManagerDelegate?
  var database = Firestore.firestore()
  
  init(delegate: NetworkManagerDelegate) {
    self.delegate = delegate
  }
  
  func locationUpdated(newLocation: CLLocationCoordinate2D) {
    guard let currentUser = User.current else {
      print(("EQ-4: There's no current user"))
      assertionFailure()
      return
    }
    
    currentUser.currentLocation = newLocation
    registerActive(user: currentUser)
  }
  
  private func registerActive(user: User) -> Void {
    guard let currentLocation = user.currentLocation else {
      print(("EQ-5: Trying to register a user as active without current location"))
      assertionFailure()
      return
    }
    
    var ref: DocumentReference? = nil
    ref = database.collection("users").addDocument(data: [
      "name": user.name,
      // TODO: send imageURL
      "dob": user.dob.timeIntervalSince1970,
      "pronoun": user.pronoun.rawValue,
      "isActive": user.isActive,
      "currentLocation": GeoPoint(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
    ]) { err in
        if let err = err {
            print("EQ-6: Error registering current user: \(err)")
        }
    }
    
    delegate?.registeredUserActive(user)
  }
}
