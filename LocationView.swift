//
//   LocationView.swift
//   app
//
//   Created by   anthony-yip on 19/7/21.
//

import Foundation
import SwiftUI

struct LocationView: View {
       
// REMINDER TO GO CHANGE THE SIZE OF EACH BUBBLE TO BASED ON THE SCREEN SIZE
       
//presents the 'bubble' in image 1
      @EnvironmentObject var model: Model
      var locationHalf: LocationHalf
      @State var nav: Bool = false
      init(locationHalf: LocationHalf) {
            self.locationHalf = locationHalf
      }
      var body: some View {
             
             
             
            ZStack {
                  NavigationLink(destination: ProfileListView().environmentObject(model), isActive: $nav) {
                        EmptyView()
                  }
                  Button(action: {
                        model.locationID = locationHalf.locationID
                        self.nav = true
                  }) {
                        VStack {
                              locationHalf.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 170, height: 170, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 40))
                                    .clipped()
                              HStack {
                                    Text(locationHalf.name).foregroundColor(.black)
                              }
                        }
                  }
            }
             
             
             
             
      }
}


struct LocationView_Previews: PreviewProvider {
      static var previews: some View {
            LocationView(locationHalf: LocationHalf(name: "Whampoa", image: Image("whampoa"), locationID: 0)).environmentObject(Model())
      }
}
