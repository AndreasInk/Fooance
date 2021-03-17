//
//  ItemDetailsView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI
import MapKit

struct ItemDetailsView: View {
    @Binding var item: Item
    @State var dateString = ""
    @State var timeTillString = ""
    @State var ready = false
    @State var edit = false
    @State var directions = false
    @State var pickup = false
    @State var img = "icon"
    @State var days = 0
    @State var landmark = Landmark(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)))
    @State var landmarks = [Landmark]()
    @ObservedObject var locationManager: LocationManager
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    
    var body: some View {
        ZStack {
            Color.clear
                .onAppear() {
                    if item.name.lowercased().contains("berr") {
                        img = "berries"
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    region = locationManager.currentRegion ?? MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: 25.7617, longitude: 80.1918),
                        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                    }
                }
               
        VStack {
            Image(img)
               
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .clipShape(Circle())
                .padding(.top, 75)
                
                .onAppear() {
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                    
                   // dateString = dateFormatterGet.string(from: item.expirationDate)
                    #warning("Disable for launch")
                    let calendar = Calendar.current
//                    let date = calendar.date(byAdding: .day, value: 6, to: item.expirationDate)
                    
                    let timeTill = Date().distance(to: item.expirationDate)
                    timeTillString = String(Int((timeTill / 86400).rounded())) + " days"
                    #warning("renable for launch")
                   days =  Int((timeTill / 86400).rounded())
                    ready = true
                }
                .padding(.bottom)
                .onAppear() {
                    getNearbyLoc()
                }
            if ready {
            LeadingTextView2(text: $item.name, size: 36)
                .padding(.horizontal)
            LeadingTextView(text: "$" +  item.price, size: 24)
                if item.name.last?.lowercased() == "s" {
                    LeadingTextView(text: item.name + " expire in " + timeTillString, size: 14)
                } else {
                    LeadingTextView(text: item.name + " expires in " + timeTillString, size: 14)
                }
            
            Toggle(isOn: $item.noti) {
                Text("Expiration Notifications")
                    .font(.custom("Poppins-Bold", size: 18, relativeTo: .headline))
                    .foregroundColor(Color("text"))
            } .padding()
                #warning("Bugged")
//            .onChange(of: item.noti, perform: { value in
//                if value {
//                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                        if success {
//                            print("All set!")
//
//                        } else if let error = error {
//                            print(error.localizedDescription)
//                        }
//                        let content = UNMutableNotificationContent()
//                        content.title = "🍓"
//                        if item.name.last?.lowercased() == "s" {
//                        content.subtitle = "Your " + item.name + " are expiring soon!"
//                        } else {
//                            content.subtitle = "Your " + item.name + " is expiring soon!"
//                        }
//                        content.sound = UNNotificationSound.default
//
//                        // show this notification five seconds from now
//                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:  Date().distance(to: item.expirationDate), repeats: false)
//
//                        // choose a random identifier
//                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                        // add our notification request
//                        UNUserNotificationCenter.current().add(request)
//                    }
//                }
//            })
                if days < 3 {
//                    Button(action: {
//                        pickup = true
//                    }) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 25)
//                                .padding()
//                                .frame(height: 100)
//                        Text("Request a pickup to donate your food")
//                            .font(.custom("Poppins", size: 18, relativeTo: .subheadline))
//                            .padding()
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(.white)
//                        }
//                    }
                    LeadingTextView(text: "Drop off your food at a local food bank", size: 18)
                    LocList(landmarks: landmarks, locationManager: LocationManager(), landmark: $landmark, directions: $directions)
                }
            Spacer()
            }
        }
            VStack {
            HStack {
                Spacer()
                Button(action: {
                   
                    
                        withAnimation(.easeInOut) {
                            edit.toggle()
                        }
                }) {
                   Text("Edit")
                    .font(.custom("Poppins", size: 16, relativeTo: .subheadline))
                    .padding()
                }
               
            }
                Spacer()
            }
            if edit {
                Color(.systemBackground)
                ShoppingAddView(item: $item, add: $edit)
                    .padding(.top, 100)
            }
        } .sheet(isPresented: $pickup, content: {
            PickupView( region: $region, locationManager: LocationManager(), schedule: $pickup)
        })
    }
    private func getNearbyLoc() {
           
           let request = MKLocalSearch.Request()
           request.naturalLanguageQuery = "Food-Bank"
        request.pointOfInterestFilter = .excludingAll
        request.region = locationManager.currentRegion ?? MKCoordinateRegion()
           let search = MKLocalSearch(request: request)
           search.start { (response, error) in
               
               if let response = response {
                   
                   let mapItems = response.mapItems
                   
                   self.landmarks = mapItems.map {
                       Landmark(placemark: $0.placemark)
                   }
               }
           }
}
}

