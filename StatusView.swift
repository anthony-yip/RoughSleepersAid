//
//   StatusView.swift
//   app
//
//   Created by   anthony-yip on 13/8/21.
//

import SwiftUI

struct StatusView: View {
      @EnvironmentObject var model: Model
      var body: some View {
           
            VStack {
                  Divider().background(Color.black)
                  FieldView(category: "Accommodation", binding: $model.locations[model.locationID].profileList[model.profileID].status.accommodation, cap: -1)
                  Divider().background(Color.black)
                  FieldView(category: "Health", binding: $model.locations[model.locationID].profileList[model.profileID].status.health, cap: -1)
                  Divider().background(Color.black)
                  FieldView(category: "Occupation", binding: $model.locations[model.locationID].profileList[model.profileID].status.occupation, cap: -1)
                  Divider().background(Color.black)
                  HStack {
                        Text("Known Issues").underline()
                        Spacer()
                  }.padding(.leading)
                  ListView().environmentObject(model)
                  Spacer()
                   
                   
            }.navigationBarTitle("\(model.locations[model.locationID].profileList[model.profileID].name) - Status")
      }

}




struct StatusView_Previews: PreviewProvider {
      static var previews: some View {
            StatusView().environmentObject(Model())
      }
}
