//
//  PickupView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI
import MapKit
import FirebaseFirestore
import FirebaseFirestoreSwift
struct PickupView: View {
    @State var arrivalDate = Date()
//    @Binding var mkRoute: MKRoute
    @Binding var region: MKCoordinateRegion
    
    @ObservedObject var locationManager: LocationManager
    @Binding var schedule: Bool
    @State var conflict = true
    @State var mkRoute = MKRoute()
    @EnvironmentObject var userData: UserData
    @State var pickups = Pickups(id: UUID().uuidString, pickups: [Pickup]())
    var body: some View {
        ZStack {
        VStack {
            MapView(region: $region, route: $mkRoute)
                .onAppear() {
                   
                }
            HStack {
            Text("Pickup Date")
                .font(.title)
                .bold()
                Spacer()
            } .padding()
        DatePicker("Please enter a date", selection: $arrivalDate)
               .labelsHidden()
            //.datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            Spacer()
            ForEach(pickups.pickups, id: \.self) { pickup in
                
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        plan()
                        
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(height: 60)
                                .padding()
                                .foregroundColor(Color("blue"))
                            Text("\(pickup.dates)")
                                .font(.headline)
                                .foregroundColor(Color(.white))
                        } .padding()
                    }
                
            }
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                plan()
                
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(height: 60)
                        .padding()
                        .foregroundColor(Color("blue"))
                    Text("Enter")
                        .font(.headline)
                        .foregroundColor(Color(.white))
                }
            }
        }
            if !conflict {
                
                Color(.systemBackground)
                    
                Text("Please select another date")
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                
                VStack {
                    HStack {
                        Button(action: {
                            conflict = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.title)
                                .padding()
                                .foregroundColor(Color("Green"))
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
    }
    }
    func plan() {
      
        let db = Firestore.firestore()
        let docRef = db.collection("pickups").document(locationManager.currentPlace?.locality ?? "error" + (locationManager.currentPlace?.administrativeArea ?? "error"))
        var pickups = Pickups(id: locationManager.currentPlace?.locality ?? "error" + (locationManager.currentPlace?.administrativeArea ?? "error"), pickups: [Pickup]())
        docRef.getDocument { (document, error) in
            
            let result = Result {
                try document?.data(as: Pickups.self)
            }
            switch result {
                case .success(let user):
                    if let user = user {
                        pickups.pickups.append(Pickup(id: UUID().uuidString, dates: arrivalDate, loc: GeoPoint(latitude: locationManager.currentLocation.coordinate.latitude, longitude: locationManager.currentLocation.coordinate.longitude)))
                        for pickup in user.pickups {
                            
                       
                            if pickup.dates.addingTimeInterval(5) > arrivalDate {
                                if pickup.dates.addingTimeInterval(-5)  < arrivalDate {
                                    conflict = true
                                }
                            }
                        }
                        if !conflict {
                                do {
                                   
                                        
                                   
                                    try db.collection("pickups").document(pickups.id).setData(from: pickups)
                                    schedule = false
                                    conflict = false
                                    
                                } catch {
                                    
                                }
                                }
                        
                    } else {
                        do {
                            pickups.pickups.append(Pickup(id: UUID().uuidString, dates: arrivalDate, loc: GeoPoint(latitude: locationManager.currentLocation.coordinate.latitude, longitude: locationManager.currentLocation.coordinate.longitude)))
                                
                           
                            try db.collection("pickups").document(pickups.id).setData(from: pickups)
                            schedule = false
                            conflict = false
                           
                        } catch {
                            
                        }
                        print("Document does not exist")
                        
                    }
                case .failure(let error):
                    print("Error decoding user: \(error)")
                }
        }
           
            
                
            
            
        
        
    }
}
