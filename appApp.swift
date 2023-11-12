//
//   appApp.swift
//   Shared
//
//   Created by   anthony-yip on 4/7/21.
//

import SwiftUI


@main
struct appApp: App {
      var body: some Scene {
            WindowGroup {
                  //testView()
                   
                  ContentView().environmentObject(Model())
            }
      }
}
