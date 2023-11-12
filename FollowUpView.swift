//
//   FollowUpView.swift
//   app
//
//   Created by   anthony-yip on 15/8/21.
//

import SwiftUI

struct FollowUpView: View {
      @EnvironmentObject var model: Model
      @State var followUp: [Reminder]
       
      var body: some View {
            SingleAxisGeometryReader { width in
                  List {
                        ForEach(0..<followUp.count, id: \.self) { i in
                              HStack(alignment: .top) {
                                    Button(action: {followUp[i].status.toggle()}) {
                                          Image(systemName: followUp[i].status ? "checkmark.circle.fill" : "circle")
                                    }
                                    VStack(alignment: .leading) {
                                          ZStack {
                                                TextField(followUp[i].content,
                                                      text: Binding(get: {followUp[i].content}, set: {followUp[i].content = $0}))
                                                      .font(.system(size: 17, weight: .heavy, design: .default))
                                                Text(followUp[i].content).opacity(0)
                                                      .background(ViewGeometry())
                                                      .onPreferenceChange(ViewSizeKey.self) {
                                                            followUp[i].contentLength = $0
                                                      }
                                                      .onChange(of: self.followUp[i].content, perform: { [followUp] newContent in
                                                            if followUp[i].contentLength.width > (width - 120) {
                                                                  if (newContent > followUp[i].content) {
                                                                        self.followUp[i].content = followUp[i].content
                                                                  }
                                                            }
                                                      })
                                          }
                                          ZStack {
                                                TextField(followUp[i].deadline,
                                                               text: Binding(get: {followUp[i].deadline}, set: {followUp[i].deadline = $0}))
                                                      .foregroundColor(.gray)
                                                Text(followUp[i].deadline).opacity(0)
                                                      .background(ViewGeometry())
                                                      .onPreferenceChange(ViewSizeKey.self) {
                                                            followUp[i].deadlineLength = $0
                                                      }
                                                      .onChange(of: self.followUp[i].deadline, perform: { [followUp] newDeadline in
                                                            if followUp[i].deadlineLength.width > (width - 90) {
                                                                  if (newDeadline > followUp[i].deadline) {
                                                                        self.followUp[i].deadline = followUp[i].deadline
                                                                  }
                                                            }
                                                      })
                                          }
                                    }
                                     
                              }
                        }
                        Button(action: {followUp.append(Reminder(status: false, content: "New Follow Up", contentLength: .zero, deadline: "New Deadline", deadlineLength: .zero))}) {
                              HStack {
                                    Image(systemName: "plus")
                                    Text("Add New Follow Up")
                              }
                        }.foregroundColor(.orange)
                         
                  }.navigationTitle("\(model.locations[model.locationID].profileList[model.profileID].name)")
                  .onDisappear(perform: {model.locations[model.locationID].profileList[model.profileID].followUp = self.followUp})
            }
      }
}

/*
struct FollowUpView_Previews: PreviewProvider {
      static var previews: some View {
            FollowUpView().environmentObject(Model())
      }
}
*/
