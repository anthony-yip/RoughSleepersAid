//
//   ReportView.swift
//   app
//
//   Created by   anthony-yip on 16/8/21.
//

import SwiftUI

struct ReportView: View {
      @Binding var location: String
      @Binding var report: String
      @Binding var assessment: String
      @Binding var visible: Int
      var body: some View {
            //ScrollView {
                  VStack(alignment: .leading) {
                        HStack {
                              Text("Location").bold()
                              Spacer()
                              Button(action: {visible = -1}, label: {Text("Done")}).foregroundColor(.blue)
                        }
                        TextField(location, text: $location).padding(.leading, 8)
                        Text("Report").bold()
                        ZStack {
                              TextEditor(text: $report)
                              Text(report).opacity(0).padding(8)
                        }
                        Text("Assessment").bold()
                        ZStack {
                              TextEditor(text: $assessment)
                              Text(assessment).padding(8).opacity(0)
                        }
                  }.padding(8).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).padding(8)
            //}
      }
}

/*
struct ReportView_Previews: PreviewProvider {
      static var previews: some View {
            ReportView()
      }
}
*/
