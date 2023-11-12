//
//   test.swift
//   app
//
//   Created by   anthony-yip on 14/8/21.
//

import SwiftUI

struct testView: View {
      // 1.
      @State private var locations = ["Beach", "Forest", "Desert"]
       
      var body: some View {
            NavigationView {
                  List {
                        // 2.
                        ForEach(0..<locations.count) { i in
                              Text(locations[i])
                        }
                  }
                  .navigationBarTitle(Text("Locations"))
                  // 3.
                  .navigationBarItems(trailing: Button(action: {
                        self.locations.append("New Location")
                  }) {
                        Image(systemName: "plus")
                  })
            }
      }
             
      // 4.
      private func addRow() {
            self.locations.append("New Location")
      }
}
