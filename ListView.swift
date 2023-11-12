//
//   ListView.swift
//   app
//
//   Created by   anthony-yip on 15/8/21.
//

import SwiftUI

struct ListView: View {
      @EnvironmentObject var model: Model
      @State var size: CGSize = .zero
       
      var body: some View {
            ScrollView {
                  LazyVStack {
                        ForEach(0..<model.locations[model.locationID].profileList[model.profileID].status.knownIssues.count, id: \.self) { i in
                              HStack(alignment: .top) {
                                    Image(systemName: "minus").padding(.top, 15)
                                    ZStack {
                                           
                                          TextEditor(text: Binding(get: {model.locations[model.locationID].profileList[model.profileID].status.knownIssues[i]},
                                                                                set: {model.locations[model.locationID].profileList[model.profileID].status.knownIssues[i] = $0})).opacity(1)
                                          Text(model.locations[model.locationID].profileList[model.profileID].status.knownIssues[i]).opacity(0).padding(8)
                                    }
                              }
                        }.padding(.leading)
                        HStack {
                              Button(action: {self.model.locations[model.locationID].profileList[model.profileID].status.knownIssues.append("New Issue"); print(size.height)}) {
                                    Image(systemName: "plus.circle").foregroundColor(.orange).padding(.leading)
                              }
                              Spacer()
                        }
                  }
            }
      }
}

struct ListView_Previews: PreviewProvider {
      static var previews: some View {
            ListView().environmentObject(Model())
      }
}
