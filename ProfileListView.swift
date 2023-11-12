//
//   ProfileListView.swift
//   app
//
//   Created by   anthony-yip on 19/7/21.
//

import Foundation
import SwiftUI
import UIKit

struct ProfileListView: View {
      //presents image 2: all the profiles within one location
      @EnvironmentObject var model: Model
      init() {
            //UIView.appearance().backgroundColor = nil
      }
       

      var body: some View {
        
            List(model.profileList) { profile in
            //profile is an instance of sturct Profile
                  ProfileListEntry(profile: profile).environmentObject(model)
            }.navigationBarTitle(model.locationName)
            .navigationBarItems(trailing: Button(action: {model.addProfile(name: "New Profile")}) {
                  Image(systemName: "plus")
            }).onAppear(perform: {
                  model.save()
            })
             
      }
}

struct ProfileListView_Previews: PreviewProvider {
      static var previews: some View {
            ProfileListView().environmentObject(Model())
      }
}
