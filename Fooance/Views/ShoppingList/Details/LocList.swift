//
//  LocList.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI
import MapKit
struct LocList: View {
    
    let landmarks: [Landmark]
    @ObservedObject var locationManager: LocationManager
    @Binding var landmark: Landmark
    @Binding var directions: Bool
    var body: some View {
            
            List {
              
                
                ForEach(self.landmarks, id: \.id) { landmark in LocRow(
                    
                    landmarkLocal: landmark, name: landmark.name,
                    lat: landmark.lat,
                    lon: landmark.lon, locationManager: locationManager, landmark: $landmark, directions: $directions
                )
                } .onAppear() {
                    
                }
                    .listRowBackground(Color("Light"))
                    .opacity(0.8)
            }
            
        .background(Color("Light"))
        
        .edgesIgnoringSafeArea([.bottom])
    }
}

