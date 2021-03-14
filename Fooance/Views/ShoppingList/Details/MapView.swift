//
//  MapView.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var route: MKRoute
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
           
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .green
            renderer.lineWidth = 4
            
            return renderer
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
      
        if route.name != "" {
        mapView.addOverlay(route.polyline)
        }
        mapView.delegate = context.coordinator
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}

import SwiftUI
import MapKit

struct City: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapExample: View {
    @State private var cities: [City] = [
        City(coordinate: .init(latitude: 30.2400, longitude: -81.3853)),
       
    ]

    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.2400, longitude: -81.3853),
        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    )

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: cities) { city in
            MapAnnotation(
                coordinate: city.coordinate,
                anchorPoint: CGPoint(x: 0.5, y: 0.5)
            ) {
                Circle()
                    .fill(Color(.systemBlue))
                    .opacity(0.4)
                    .frame(width: 44, height: 44)
            }
        } .ignoresSafeArea()
    }
}
