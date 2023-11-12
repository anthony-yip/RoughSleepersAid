//
//   DataListEntry.swift
//   app
//
//   Created by   anthony-yip on 15/8/21.
//

import SwiftUI

struct DataListEntry: View {
      var label: String
      var description: String
      var body: some View {
            HStack {
                  VStack {
                        HStack {
                              Text(label)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                              Spacer()
                        }
                        HStack {
                              Text(description)
                                    .foregroundColor(Color.gray)
                                     
                              Spacer()
                        }
                         
                  }.padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
                  Image(systemName: "chevron.right").padding(.trailing)
                   
            }
      }
}

