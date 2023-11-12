//
//   TimelineView.swift
//   app
//
//   Created by   anthony-yip on 16/8/21.
//

import SwiftUI

struct TimelineView: View {
      @EnvironmentObject var model: Model
      @State var timeline: [TimelineEntry]
      @State var visible: Int = -1
      var body: some View {
             
                  ZStack {
                        if (visible == -2) {
                              List {
                                    ForEach(0...(timeline.count - 2), id: \.self) { i in
                                          VStack(alignment: .leading) {
                                                HStack {
                                                      Image(systemName: "circle").padding(3)
                                                      DatePicker(formatter.string(from: timeline[i].date), selection: Binding(get: {timeline[i].date}, set: {timeline[i].date = $0}), displayedComponents: [.date])
                                                }
                                                HStack {
                                                      Image(systemName: "circle.fill").font(.caption2).padding(6)
                                                      TextField(timeline[i].description, text: Binding(get: {timeline[i].description}, set: {timeline[i].description = $0})).font(.callout).foregroundColor(.gray)
                                                }
                                                HStack {
                                                      Image(systemName: "circle.fill").font(.caption2).padding(6)
                                                      Button(action: {visible = i}) {
                                                            Text("View Report").font(.callout).foregroundColor(.orange)
                                                      }
                                                }
                                          }
                                    }
                                    HStack {
                                          Image(systemName: "plus")
                                          Text("New Entry")
                                    }.foregroundColor(.orange)
                              }.onAppear(perform: {
                                                let seconds = 0.1;
                                                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                                      visible = -1
                                                }})

                        }
                        else if (visible == -1) {
                              List {
                                    ForEach(0..<timeline.count, id: \.self) { i in
                                          VStack(alignment: .leading) {
                                                HStack {
                                                      Image(systemName: "circle").padding(3)
                                                      DatePicker(formatter.string(from: timeline[i].date), selection: Binding(get: {timeline[i].date}, set: {timeline[i].date = $0}), displayedComponents: [.date])
                                                }
                                                HStack {
                                                      Image(systemName: "circle.fill").font(.caption2).padding(6)
                                                      TextField(timeline[i].description, text: Binding(get: {timeline[i].description}, set: {timeline[i].description = $0})).font(.callout).foregroundColor(.gray)
                                                }
                                                HStack {
                                                      Image(systemName: "circle.fill").font(.caption2).padding(6)
                                                      Button(action: {visible = i}) {
                                                            Text("View Report").font(.callout).foregroundColor(.orange)
                                                      }
                                                }
                                          }
                                    }
                                    Button(action: {
                                          timeline.append(TimelineEntry(date: Date(), description: "New Description", report: "New Report", assessment: "New Assessment", location: "New Location"))
                                          visible = -2
                                    }) {
                                          HStack {
                                                Image(systemName: "plus")
                                                Text("New Entry")
                                          }.foregroundColor(.orange)
                                    }
                              }.navigationBarTitle("\(model.locations[model.locationID].profileList[model.profileID].name) - Timeline")
                        }

                        if (visible >= 0) {
                              ReportView(location: Binding(get: {timeline[visible].location}, set: {timeline[visible].location = $0}),
                                               report: Binding(get: {timeline[visible].report}, set: {timeline[visible].report = $0}),
                                               assessment: Binding(get: {timeline[visible].assessment}, set: {timeline[visible].assessment = $0}),
                                               visible: $visible)
                        }
                  }.onDisappear(perform: {model.locations[model.locationID].profileList[model.profileID].timeline = self.timeline})

      }
}

struct TimelineView_Previews: PreviewProvider {
      static var previews: some View {
            TimelineView(timeline: Model().locations[Model().locationID].profileList[Model().profileID].timeline).environmentObject(Model())
      }
}
