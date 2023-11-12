//
//   FieldView.swift
//   app
//
//   Created by   anthony-yip on 13/8/21.
//

import SwiftUI

struct FieldView: View {
    
      @State var textSize: CGSize = .zero
       
      var category: String
      @Binding var binding: String
      var cap: Int
       
      var body: some View {
            SingleAxisGeometryReader { width in
                   
                  VStack(spacing: 4.0) {
                        HStack {
                              Text(category).underline()
                              Spacer()
                        }
                        ZStack {
                              TextField(binding, text: $binding)
                                    .onChange(of: self.binding, perform: { value in
                                          if value.count > 100 {
                                                self.binding = String(value.prefix(100))
                                                print("yes")
                                                print(width)
                                          }
                                    })
                                     
                              Text(binding).opacity(0)
                                    .background(ViewGeometry())
                                    .onPreferenceChange(ViewSizeKey.self) {
                                          textSize = $0
                                    }
                                    .onChange(of: self.binding, perform: { [binding] value in
                                          if (cap == -1) {
                                                if textSize.width > (width - 36) {
                                                      self.binding = binding
                                                }
                                          }
                                          else {
                                                if value.count > cap {
                                                      self.binding = binding
                                                }
                                          }

                                    })
                               
                        }
                  }.padding(.leading)

            }

      }
}
/*
struct FieldView_Previews: PreviewProvider {
      static var previews: some View {

            FieldView(category: "Name", binding: Binding(get: {name}, set: {name = $0}))
      }
}
*/
