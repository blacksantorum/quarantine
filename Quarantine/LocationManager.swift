//
//  LocationManager.swift
//  Quarantine
//
//  Created by Chris Tibbs on 3/28/20.
//  Copyright © 2020 Chris Tibbs. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationDelegate: AnyObject {
  func locationUpdated(newLocation: CLLocationCoordinate2D) -> Void
}

class LocationManager: NSObject, CLLocationManagerDelegate {
  weak var delegate: LocationDelegate?
  let locationManager: CLLocationManager
  
  init(delegate: LocationDelegate) {
    self.delegate = delegate
    self.locationManager = CLLocationManager()
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    super.init()
    locationManager.delegate = self
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else {
      print("WQ-1: There was no updated location")
      return
    }
    
    guard let delegate = self.delegate else {
      print(("EQ-2: Location manager has no delegate"))
      return
    }
    
    delegate.locationUpdated(newLocation: location.coordinate)
    print("New location sent to delegate")
  }
}
