//
//  Data.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI
import MapKit
struct ItemsList: Identifiable, Hashable, Codable {
    var id = UUID()
    var items: [Item]
    var date: Date
}
struct Item: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var price: String
    var expirationDate: Date
    var check: Bool
    var noti: Bool
    var notiSet: Bool
}



struct Landmark {

    let placemark: MKPlacemark

    var id: UUID {
        return UUID()
    }
    var name: String {
       
        return self.placemark.name ?? ""
    }
    
    var lat: Double {
        return self.placemark.coordinate.latitude
    }
    
    var lon: Double {
        return self.placemark.coordinate.longitude
    }
}

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Pickups: Identifiable, Codable, Equatable, Hashable {
    var id: String
    var pickups: [Pickup]
   
    
}

struct Pickup: Identifiable, Codable, Equatable, Hashable {
    var id: String
    var dates: Date
    var loc: GeoPoint
    
}
