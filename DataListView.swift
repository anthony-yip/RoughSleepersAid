//
//   DataListView.swift
//   app
//
//   Created by   anthony-yip on 19/7/21.
//

import Foundation
import SwiftUI

struct DataListView: View {
      @EnvironmentObject var model: Model
    
      var body: some View {
             
            VStack(spacing: 0) {
                  VStack {
                        NavigationLink(destination: InfoView().environmentObject(model)) {
                              DataListEntry(label: "Info", description: "Name, age, NRIC, race")
                        }
                        Divider().foregroundColor(.black)
                        NavigationLink(destination: StatusView().environmentObject(model)) {
                              DataListEntry(label: "Status", description: "Health, accomodation, occupation, known issues...")
                        }
                        Divider().foregroundColor(.black)
                        NavigationLink(destination: OrgsInvolvedView(list: model.locations[model.locationID].profileList[model.profileID].organisations).environmentObject(model)) {
                              DataListEntry(label: "Organisations Involved", description: "")
                        }
                  }
                  VStack {
                        Divider().foregroundColor(.black)
                        NavigationLink(destination: FollowUpView(followUp: model.locations[model.locationID].profileList[model.profileID].followUp).environmentObject(model)) {
                              DataListEntry(label: "Follow Up", description: "Tasks, long-term plans")
                        }
                        Divider().foregroundColor(.black)
                        NavigationLink(destination: TimelineView(timeline: model.locations[model.locationID].profileList[model.profileID].timeline)) {
                              DataListEntry(label: "Timeline", description: "Report, assessment, location, pictures")
                        }
                        Divider().foregroundColor(.black)
                        NavigationLink(destination: NotesView().environmentObject(model)) {
                              DataListEntry(label: "Other Notes", description: "")
                        }
                  }

                  Spacer()
            }.navigationBarTitle(Text(model.profileList[model.profileID].name))
            .onAppear(perform: {
                  model.save()
            })
             
      }
}

struct DataListView_Previews: PreviewProvider {
      static var previews: some View {
            DataListView().environmentObject(Model())
      }
}
