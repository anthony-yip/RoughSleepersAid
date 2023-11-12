
//   Location.swift
//   app (iOS)
//
//   Created by   anthony-yip on 4/7/21.
//

import Foundation
import SwiftUI
import UIKit
import Combine


struct SingleAxisGeometryReader<Content: View>: View
{
      private struct SizeKey: PreferenceKey
      {
            static var defaultValue: CGFloat { 10 }
            static func reduce(value: inout CGFloat, nextValue: () -> CGFloat)
            {
                  value = max(value, nextValue())
            }
      }

      @State private var size: CGFloat = SizeKey.defaultValue

      var axis: Axis = .horizontal
      var alignment: Alignment = .center
      let content: (CGFloat)->Content

      var body: some View
      {
            content(size)
                  .frame(maxWidth:   axis == .horizontal ? .infinity : nil,
                             maxHeight: axis == .vertical    ? .infinity : nil,
                             alignment: alignment)
                  .background(GeometryReader
                  {
                        proxy in
                        Color.clear.preference(key: SizeKey.self, value: axis == .horizontal ? proxy.size.width : proxy.size.height)
                  })
                  .onPreferenceChange(SizeKey.self) { size = $0 }
      }
}

struct ViewSizeKey: PreferenceKey {
      static var defaultValue: CGSize = .zero

      static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
      }
}

struct ViewGeometry: View {
      var body: some View {
            GeometryReader { geometry in
                  Color.clear
                        .preference(key: ViewSizeKey.self, value: geometry.size)
            }
      }
}

struct BottomLineTextFieldStyle: TextFieldStyle {
      func _body(configuration: TextField<Self._Label>) -> some View {
            VStack() {
                  configuration
                  Rectangle()
                        .frame(height: 0.5, alignment: .bottom)
                        .foregroundColor(Color.secondary)
            }
      }
}

struct Location: Identifiable, Decodable, Encodable {
//store all the location data
      var id: Int
      var name: String
      var filename: String
      var profileList: [Profile]
}

struct LocationHalf {
      //var id: Int
      var name: String
      var image: Image
      var locationID: Int
}

struct Profile: Identifiable, Decodable, Encodable {
      var id: Int
      var name: String
      var info: Info
      var status: Status
      var organisations: [Organisation]
      var followUp: [Reminder]
      var timeline: [TimelineEntry]
      var notes: String
      var locationID: Int
}

struct Info: Decodable, Encodable {
       

      var fullName: String
      var nric: String
      var age: String
      var race: String
      var profileID: Int
}

struct Status: Decodable, Encodable {
      var health: String
      var accommodation: String
      var occupation: String
      var knownIssues: [String]
      var profileID: Int
}

struct Reminder: Decodable, Encodable {
      var status: Bool
      var content: String
      var contentLength: CGSize = .zero
      var deadline: String
      var deadlineLength: CGSize = .zero
}

struct TimelineEntry: Decodable, Encodable {
      var date: Date
      var description: String
      var report: String
      var assessment: String
      var location: String
}

struct Organisation: Decodable, Encodable {
      var name: String
      var description: String
}

struct LocationPair: Identifiable {
      var id: Int
      var pair: [LocationHalf]
}

var formatter: DateFormatter {
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      formatter.timeStyle = .none
      formatter.locale = Locale(identifier: "en_GB")
      return formatter
}





class Model: ObservableObject {
      //where all the data storage happens
       
      static let saveKey = "SavedData"
      let defaultSave = [
            Location(
                  id: 0,
                  name: "Whampoa",
                  filename: "whampoa",
                  profileList: [
                        Profile(
                              id: 0,
                              name: "Mr Tan",
                              info: Info(fullName: "Mr Tan Chee Kiat", nric: "S239840C", age: "56", race: "Chinese", profileID: 0),
                              status: Status(health: "healthy, smoker", accommodation: "available", occupation: "security guard", knownIssues: ["no phone", "34", "56"], profileID: 0),
                              organisations: [Organisation(name: "AA", description: "lorem ipsum delta"),
                                                                    Organisation(name: "BB", description: "iiulum vas fef")],
                              followUp: [Reminder(status: false, content: "Buy Teh Halia", deadline: "Regular (Weekly"),
                                               Reminder(status: false, content: "Get Phone", deadline: "ASAP"),
                                               Reminder(status: false, content: "Inquire about housing", deadline: "01/06/21")],
                              timeline: [TimelineEntry(date: Date(timeIntervalSince1970: 1591408859), description: "First contact", report: "kirrem lorem   feifeifenif", assessment: "afufindlvk", location: "Blk 408"),
                                               TimelineEntry(date: Date(timeIntervalSince1970: 1592013659), description: "Contacted social services", report: "erifwqfnoiefnisn iefbiuwebnfiuwfe ", assessment: "wfuebfeiubfieub", location: "Blk 908"),
                                               TimelineEntry(date: Date(timeIntervalSince1970: 1592618459), description: "Found temporary accommodation", report: "efiubiwefbui efiubwifebi f", assessment: "iueb iueb iueb   feuibebui", location: "Centre Mile Food Centre")],
                              notes: "",
                              locationID: 0
                        )
                  ]
            ),
            Location(
                  id: 1,
                  name: "Boon Lay",
                  filename: "boon lay",
                  profileList: []
            ),
            Location(id: 2, name: "Woodlands", filename: "woodlands", profileList: [])
            //Location(id: 3, name: "Toa Payoh", profileList: [])
      ]
       
      let defaultPairList = [LocationPair(id: 0, pair: [LocationHalf(name: "Whampoa", image: Image("whampoa"), locationID: 0),
                                                                                 LocationHalf(name: "Boon Lay", image: Image("boon lay"), locationID: 1)]),
                                                         LocationPair(id: 1, pair: [LocationHalf(name: "Woodlands", image: Image("woodlands"), locationID: 2)
                                                                                                        ])]
       
      @Published var locations: [Location]
      @Published var locationPairList: [LocationPair]
       
      var locationID: Int
      var profileID: Int
      var size: Int
       
      //computed properties
      var profileList: [Profile] {
            locations[locationID].profileList
      }
       
      var locationName: String {
            locations[locationID].name
      }
       
      var info: Info {
            profileList[profileID].info
      }

      var status: Status {
            profileList[profileID].status
      }
       
      init() {
             
            self.locationID = 0
            self.profileID = 0
            self.size = 0
            self.locations = defaultSave
            self.locationPairList = defaultPairList
             
            if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
                  if let decoded = try? JSONDecoder().decode([Location].self, from: data) {
                        self.locations = decoded
                  }
            }
       
             
      }

      func saveImage(_ filename: String) {
            // my internal use
            let image = UIImage(named: filename)
             
            if let data = image?.pngData() {
                  // Create URL
                  let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                  let url = documents.appendingPathComponent(filename + ".png")

                  do {
                        // Write to Disk
                        try data.write(to: url)

                        // Store URL in User Defaults
                        UserDefaults.standard.set(url, forKey: filename)

                  } catch {
                        print("Unable to Write Data to Disk (\(error))")
                  }
            }
      }
       
      func getImage(_ filename: String) -> Image {
             
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documents.appendingPathComponent(filename + ".png")
            var returnImage: Image = Image(systemName: "plus")
             
            let savedUIImage = UIImage(contentsOfFile: url.path)
            if let unwrapped = savedUIImage {
                  returnImage = Image(uiImage: unwrapped)
            }
            return returnImage
      }
       
      func getAllImages() -> [LocationPair] {
            for location in locations {
                  //create locationPairList by reading from memory (filenames are in self.locations)
            }
      }
       
      func save() {
            if let encoded = try? JSONEncoder().encode(locations) {
                  UserDefaults.standard.set(encoded, forKey: Self.saveKey)
            }
            if let unwrapped = self.getSizeOfUserDefaults() {
                  self.size = unwrapped
            }
            print(self.size)
      }
       
      func clearData() {
            if let encoded = try? JSONEncoder().encode(self.defaultSave) {
                  UserDefaults.standard.set(encoded, forKey: Self.saveKey)
            }
      }
       
      func addLocation(name: String, image: Image) {
            let newLocationID = locations.count
            let newLocation = Location(id: newLocationID, name: name, filename: name, profileList: [])
            let newLocationHalf = LocationHalf(name: name, image: image, locationID: newLocationID)
            locations.append(newLocation)
            let finalPair =   locationPairList[locationPairList.count - 1]
            if (finalPair.pair.count == 2) {
                  locationPairList.append(LocationPair(id: locationPairList.count, pair: [newLocationHalf]))
            }
            else {
                  locationPairList[locationPairList.count - 1].pair.append(newLocationHalf)
            }
             

             
      }

      func getSizeOfUserDefaults() -> Int? {
            guard let libraryDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else {
                  return nil
            }

            guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
                  return nil
            }

            let filepath = "\(libraryDir)/Preferences/\(bundleIdentifier).plist"
            let filesize = try? FileManager.default.attributesOfItem(atPath: filepath)
            let retVal = filesize?[FileAttributeKey.size]
            return retVal as? Int
      }
       
      func addProfile(name: String) {
            let newProfileID = profileList.count
            let newProfile = Profile(id: newProfileID, name: name, info: Info(fullName: "", nric: "", age: "", race: "", profileID: newProfileID),
                                                  status: Status(health: "", accommodation: "", occupation: "", knownIssues: ["", "", "", "", ""], profileID: newProfileID), organisations: [], followUp: [], timeline: [], notes: "", locationID: locationID)
            self.locations[locationID].profileList.append(newProfile)
            save()
      }
       

       
}



struct NavigationBarModifier: ViewModifier {

      var backgroundColor: UIColor?
      var titleColor: UIColor?

      init(backgroundColor: UIColor?, titleColor: UIColor?) {
            self.backgroundColor = backgroundColor
            let coloredAppearance = UINavigationBarAppearance()
            coloredAppearance.configureWithTransparentBackground()
            coloredAppearance.backgroundColor = backgroundColor
            coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
            coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

            UINavigationBar.appearance().standardAppearance = coloredAppearance
            UINavigationBar.appearance().compactAppearance = coloredAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
      }

      func body(content: Content) -> some View {
            ZStack{
                  content
                  VStack {
                        GeometryReader { geometry in
                              Color(self.backgroundColor ?? .clear)
                                    .frame(height: geometry.safeAreaInsets.top)
                                    .edgesIgnoringSafeArea(.top)
                              Spacer()
                        }
                  }
            }
      }
}

extension View {

      func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
            self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
      }

}
