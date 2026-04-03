//
//  LocationView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 28/03/26.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

struct LocationView: View {
    @Environment(\.dismiss) var dismiss
    @State var camera:MapCameraPosition = .automatic
    @State var mapTypeStandard : Bool = false
    @State var searchText : String = ""

    @StateObject private var locationManager = LocationManager()
    @State var results : [MKMapItem] = []
    
    @State var selectedLocation: CLLocationCoordinate2D?
    
    @Binding var addressText:String
    @Binding var latitude:Double
    @Binding var longitude:Double
    
    
    var isPicker: Bool = true
    var body: some View {
        
        VStack(alignment: .leading, spacing:18){
            
            HStack {
                            TextField("Search location...", text: $searchText)
                                .textFieldStyle(.roundedBorder)
                            
                            Button("Search") {
                                searchLocation()
                            }
                        }
                        .padding(.horizontal)
            ZStack(alignment: .top) {
                
                MapReader { proxy in
                    Map(position: $camera) {
                        
                        if let selected = selectedLocation {
                            Marker("Selected", systemImage: "mappin", coordinate: selected)
                        }
                        
                        UserAnnotation()
                    }
                    .mapControls {
                        MapUserLocationButton()
                    }
                    .onTapGesture { point in
                        
                        guard isPicker else { return }
                        
                        if let coordinate = proxy.convert(point, from: .local) {
                            selectedLocation = coordinate
                            
                            Task {
                                let addr = await locationManager.fetchAddress(from: coordinate)
                                await MainActor.run {
                                    locationManager.address = addr
                                    addressText = addr
                                    latitude = coordinate.latitude
                                    longitude = coordinate.longitude
                                }
                            }
                        }
                    }
                }
                
                // 🔍 SEARCH RESULTS OVERLAY (FIXED)
                if !results.isEmpty {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(results, id: \.self) { item in
                                
                                Button {
                                    selectLocation(item)
                                } label: {
                                    VStack(alignment: .leading) {
                                        Text(item.name ?? "Unknown")
                                            .font(.headline)
                                        
                                        Text(item.placemark.title ?? "")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                }
                                
                                Divider()
                            }
                        }
                    }
                    .frame(maxHeight: 250)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding()
                }
            }
            Group{
                Text("Address: ").font(.title3).bold() +
    
                    Text(locationManager.address ?? "Select a location").font(.headline).foregroundStyle(.customDarkGray)
                
                
            }.padding().frame(maxWidth: .infinity,alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.white)).shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5).padding(.horizontal,12)
            
            Button(action:{
                dismiss()
            }){
                Text("Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity,maxHeight: 30)
                    .padding()
                    .background(
                        Color("darkPurple")
                    )
                    .foregroundColor(.white)
                    .cornerRadius(12).padding(.horizontal,12)
            }
            
        }.onAppear{
            locationManager.start()
        }
    }
    
}


class LocationManager:NSObject, ObservableObject, CLLocationManagerDelegate{
    
    private var manager = CLLocationManager()
    private var lastFetchedLocation: CLLocation?
    @Published var location : CLLocationCoordinate2D?
    @Published var address : String?
    
    override init(){
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func start(){
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways{
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else{return}
        
        if let last = lastFetchedLocation, newLocation.distance(from: last) < 50{
            return
        }
        lastFetchedLocation = newLocation
           location = newLocation.coordinate
                Task{
                    let addr = await fetchAddress(from:newLocation.coordinate)
                    await MainActor.run{
                        self.address = addr
                    }
                }
        
      }
      
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)

    }
    
    func fetchAddress(from coordinate: CLLocationCoordinate2D) async -> String {
        
        let location = CLLocation(latitude: coordinate.latitude,
                                  longitude: coordinate.longitude)
        
        do {
            let placemarks = try await CLGeocoder()
                .reverseGeocodeLocation(location, preferredLocale: .current)
            
            if let place = placemarks.first {
                let address = [
                    place.name,
                    place.locality,
                    place.administrativeArea,
                    place.country
                ]
                .compactMap { $0 }
                .joined(separator: ", ")
                
                return address
            }
            
            return "Unknown Address"
            
        } catch {
            return "Error fetching address"
        }
    }
}

extension LocationView {
    func searchLocation(){
        Task{
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText
            
            let search = MKLocalSearch(request: request)
            do{
                let response = try await search.start()
                results = response.mapItems
            }catch{
                print("Search error:\(error.localizedDescription)")
            }
        }
    }
    
    func selectLocation(_ item:MKMapItem){
        let coordinate = item.placemark.coordinate
        selectedLocation = coordinate
        camera = .region(MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500))
        let address = item.placemark.title ?? item.name ?? "Unknown"
        locationManager.address = address
        addressText = address
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        results = []
    }
    
}

//#Preview {
//    LocationView()
//}
