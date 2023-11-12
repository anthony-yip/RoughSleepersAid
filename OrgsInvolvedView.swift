//
//   OrgsInvolvedView.swift
//   app
//
//   Created by   anthony-yip on 15/8/21.
//

import SwiftUI

struct OrgsInvolvedView: View {
      @EnvironmentObject var model: Model
      @State var list: [Organisation]
      var body: some View {
            List {
                  ForEach(0..<list.count, id: \.self) { i in
                        VStack {
                               
                              TextField(list[i].name, text: Binding(get: {list[i].name}, set: {list[i].name = $0})).font(.system(size: 17, weight: .heavy, design: .default))
                              ZStack {
                                    TextEditor(text: Binding(get: {self.list[i].description}, set: {self.list[i].description = $0}))
                                    Text(self.list[i].description).opacity(0).padding(8)
                              }
                        }
                  }
                  Button(action: {list.append(Organisation(name: "New Organisation", description: "Insert Description"))}) {
                        HStack {
                              Image(systemName: "plus.circle")
                              Text("Add New Organisation")
                        }.foregroundColor(.orange)
                  }
            }.navigationBarTitle("\(model.locations[model.locationID].profileList[model.profileID].name) - Organisations")
            .onDisappear(perform: {
                  model.locations[model.locationID].profileList[model.profileID].organisations = self.list
            })
      }
}

struct OrgsInvolvedView_Previews: PreviewProvider {
      static var previews: some View {
            OrgsInvolvedView(list: [Organisation(name: "AA", description: "lorem ipsum delta"),
                                                Organisation(name: "BB", description: "iiulum vas fef")]).environmentObject(Model())
      }
}
