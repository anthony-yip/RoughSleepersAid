//
//   NotesView.swift
//   app
//
//   Created by   anthony-yip on 17/8/21.
//

import SwiftUI

struct NotesView: View {
      @EnvironmentObject var model: Model
      var body: some View {
            VStack {
                  TextEditor(text: Binding(get: {model.locations[model.locationID].profileList[model.profileID].notes}, set: {model.locations[model.locationID].profileList[model.profileID].notes = $0})).padding(.leading)
                  Spacer()
            }.navigationBarTitle("\(model.locations[model.locationID].profileList[model.profileID].name) - Notes")
      }
}

struct NotesView_Previews: PreviewProvider {
      static var previews: some View {
            NotesView().environmentObject(Model())
      }
}


