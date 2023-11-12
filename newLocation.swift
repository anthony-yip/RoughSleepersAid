//
//   newLocation.swift
//   app
//
//   Created by   anthony-yip on 26/7/21.
//

import SwiftUI

struct NewLocationView: View {
       
      //GO AND ADD THE FUNCTIONALITY OF UPLOADING IMAGES USING saveImage()
       
      @State var locationName: String = "New Location Name"
      @EnvironmentObject var model: Model
      @Binding var newLoc: Bool
      var body: some View {
            ZStack {
                
                  RoundedRectangle(cornerRadius: 30).frame(width: 300, height: 200, alignment: .center)
                        .foregroundColor(.white)
                  VStack {
                        HStack {
                              Button(action: {newLoc.toggle()}) {
                                    Text("Cancel")
                                          .padding([.top, .leading])
                              }
                              Spacer()
                              Button(action: {
                                    newLoc.toggle()
                                    model.addLocation(name: locationName, image: Image("toa payoh"))
                              }) {
                                    Text("Done")
                                          .padding([.top, .trailing])
                              }
                        }
                         
                        Text("New Location").bold()
                         
                        HStack {
                              Spacer()
                              Button(action: {}) {
                                    VStack {
                                          Image(systemName: "photo").font(.largeTitle).padding(.bottom, 0.25)
                                          Text("Upload Photo").font(.system(size: 12))
                                    }
                               
                              }.padding([.top, .leading], 10.0)
                              VStack {
                                    TextField("Enter location name", text: $locationName).multilineTextAlignment(.leading).padding(.top, 35).padding(.leading, 10)
                                    Divider().padding(.top, -5)
                              }
                        }
                         
                        Spacer()
                  }.frame(width: 300, height: 200, alignment: .center)
                   
            }
      }
}
