//
//   ProfileListEntry.swift
//   app
//
//   Created by   anthony-yip on 9/8/21.
//

import SwiftUI

struct ProfileListEntry: View {
       
      @EnvironmentObject var model: Model
      @State var nav: Bool = false
      var profile: Profile
       
      var body: some View {
            ZStack {
                  NavigationLink(destination: DataListView().environmentObject(model), isActive: $nav) {
                        EmptyView()
                  }
                  Button(action: {
                        model.profileID = profile.id
                        self.nav = true
                  }) {
                        HStack {
                              Text(profile.name)
                              Spacer()
                        }
                         
                  }
            }
      }
}

/*
struct ProfileListEntry_Previews: PreviewProvider {
      static var previews: some View {
            ProfileListEntry()
      }
}
*/
