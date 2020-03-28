//
//  ContentView.swift
//  Quarantine
//
//  Created by Chris Tibbs on 3/28/20.
//  Copyright © 2020 Chris Tibbs. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
  @EnvironmentObject private var user: User
  
    var body: some View {
      MapView().environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      let user = User(name: "Chris Tibbs", dob: Date(), pronoun: "He")!
      return ContentView()
      .environmentObject(user)
      
    }
}
