//
//  LocationManager.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import Foundation
import CoreLocation
import Combine
import MapKit
class LocationManager: NSObject, ObservableObject {

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }

    @Published var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var currentRegion: MKCoordinateRegion?
    @Published var currentPlace: CLPlacemark?
    @Published var completer = MKLocalSearchCompleter()
    @Published var search = ""
    @Published var show = false
    
    @Published var speed = 0.0
    @Published var currentLocation = CLLocation()
    @Published var stopLocation = CLLocation()
    var last: CLLocation?
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }

    }

    let objectWillChange = PassthroughSubject<Void, Never>()

    private let locationManager = CLLocationManager()
    
    

    func processLocation(_ current:CLLocation) {
          guard last != nil else {
              last = current
              return
          }
           speed = current.speed
          if (speed > 0) {
              print(speed) // or whatever
          } else {
              speed = last!.distance(from: current) / (current.timestamp.timeIntervalSince(last!.timestamp))
              print(speed)
          }
          last = current
      }
}

extension LocationManager: CLLocationManagerDelegate {

      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
          return
        }

        manager.requestLocation()
      }

      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            processLocation(location)
        }
       
        guard let firstLocation = locations.first else {
          return
        }
        currentLocation = firstLocation
        let commonDelta: CLLocationDegrees = 25 / 111 // 1/111 = 1 latitude km
        let span = MKCoordinateSpan(latitudeDelta: commonDelta, longitudeDelta: commonDelta)
        let region = MKCoordinateRegion(center: firstLocation.coordinate, span: span)

        currentRegion = region
        completer.region = region
        
//        CLGeocoder().reverseGeocodeLocation(firstLocation) { places, _ in
//            guard let firstPlace = places?.first, self.search == "" else {
//               
//            return
//          }
//
//          self.currentPlace = firstPlace
//          self.search = firstPlace.abbreviation
//          
//        }
      
       
      }

      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error requesting location: \(error.localizedDescription)")
      }
    }


