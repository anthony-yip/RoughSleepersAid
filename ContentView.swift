//
//  ContentView1.swift
//  app
//
//

import SwiftUI

struct ContentView: View {
    @State private var nav = false
    @State private var newLoc = false
    private var brightnessAmount: Double = 0
    @EnvironmentObject var model: Model

    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    LazyVStack {
                        ForEach(model.locationPairList) { locationPair in
                            if (locationPair.id == model.locationPairList.count - 1) && (locationPair.pair.count == 1) {
                                HStack(alignment: .top, spacing: 20) {
                                    LocationView(locationHalf: locationPair.pair[0]).environmentObject(model).padding(.leading)
                                    Spacer()
                                }
                            }
                            else {
                                HStack(alignment: .top, spacing: 20) {
                                    LocationView(locationHalf: locationPair.pair[0]).environmentObject(model)
                                    LocationView(locationHalf: locationPair.pair[1]).environmentObject(model)
                                }
                            }

                        }
                    }
                }.navigationTitle(Text("Locations"))
                .navigationBarItems(trailing:
                                        Button(action: {newLoc.toggle()}) {
                                        Image(systemName: "plus").font(.system(size: 20))
                                    })
        
            }.brightness(-0.5 * (newLoc ? 1 : 0)).disabled(newLoc)
            if newLoc {
                NewLocationView(newLoc: $newLoc).environmentObject(model)
            }
        }
    }
}


//LocationHalf(name: "Toa Payoh", image: Image("toa payoh"), locationID: 3)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Model())
    }
}
