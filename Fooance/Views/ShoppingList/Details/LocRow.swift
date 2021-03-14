//
//  LocRow.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI
import MapKit
struct LocRow: View {
    @State var landmarkLocal: Landmark
    @State var name: String
    @State var lat: Double
    @State var lon: Double
    @ObservedObject var locationManager: LocationManager
    @State var distanceInMiles = 0.0
    @Binding var landmark: Landmark
    @Binding var directions: Bool
    var body: some View {
        Button(action: {
           /// locationManager.stopLocation = CLLocation(latitude: lat, longitude: lon)
            
//            locationManager.buildRoute()
//                if !locationManager.route.stops.isEmpty {
//                directions = true
//                }
            
        }) {
            
        ZStack {
            Color(.clear)
                .onAppear() {
                    let distanceInMeters = locationManager.currentLocation.distance(from: CLLocation(latitude: lat, longitude: lon))
                    distanceInMiles = distanceInMeters*0.000621
                }
            HStack {

                ZStack {

                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("blue"), Color("blue")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 60, height: 60, alignment: .center)


                    VStack {

                        Text(distanceInMiles.rounded(toPlaces: 1).removeZerosFromEnd())
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                            .font(.custom("Poppins", size: 14, relativeTo: .subheadline))


                        Text("Mi")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                            .font(.custom("Poppins", size: 14, relativeTo: .subheadline))
     
                    }
                }
               
Spacer()

                VStack(alignment: .leading) {

                    Text(name)
                        .foregroundColor(Color("text"))
                        .font(.custom("Poppins", size: 16, relativeTo: .headline))
                        .multilineTextAlignment(.trailing)


                   
                }
             
            }
        }
        }
    }
}
