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
    delegate?.registeredUserActive(user)
  }
}
