//
//   InfoView.swift
//   app
//
//   Created by   anthony-yip on 13/8/21.
//

import SwiftUI

struct InfoView: View {
      @EnvironmentObject var model: Model
      var body: some View {
           
            VStack {
                  Divider().background(Color.black)
                  FieldView(category: "Name", binding: $model.locations[model.locationID].profileList[model.profileID].info.fullName, cap: -1)
                  Divider().background(Color.black)
                  FieldView(category: "NRIC", binding: $model.locations[model.locationID].profileList[model.profileID].info.nric, cap: 9)
                  Divider().background(Color.black)
                  FieldView(category: "Age", binding: $model.locations[model.locationID].profileList[model.profileID].info.age, cap: 3)
                  Divider().background(Color.black)
                  FieldView(category: "Race", binding: $model.locations[model.locationID].profileList[model.profileID].info.race, cap: -1)
                  Divider().background(Color.black)
                  Spacer()
            }.navigationBarTitle("\(model.locations[model.locationID].profileList[model.profileID].name) - Info")
      }
}

struct InfoView_Previews: PreviewProvider {
      static var previews: some View {
            InfoView().environmentObject(Model())
      }
}
