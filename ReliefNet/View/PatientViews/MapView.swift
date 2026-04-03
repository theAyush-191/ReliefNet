//
//  MapView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 16/03/26.
//

import SwiftUI
import MapKit

//MARK: - Map View
struct MapView:View{
    let doctorName:String
    let lat:Double
    let long:Double
    
    var location : CLLocationCoordinate2D {
        CLLocationCoordinate2DMake(lat, long)
    }
    
//    var yourLocation : CLLocationCoordinate2D {
//        CLLocationCoordinate2DMake(26.888448, 81.055612)
//    }
    
    @State var camera : MapCameraPosition = .automatic
    
    @State var mapTypeStandard : Bool = false
    
    var body : some View{
        VStack(alignment: .leading, spacing: 12) {

            ZStack{
                Map(position: $camera){
                    Marker(doctorName, systemImage: "mappin", coordinate:location)
                    
//                    Marker("Ayush (You)",systemImage: "figure.wave", coordinate: yourLocation).tint(.blue)
                    
                }.safeAreaInset(edge: .top,alignment:.trailing){
                    Button(action:{
                        openInAppleMaps(lat: lat, long: long, placeName: doctorName)
                    }){
                        
                            Image(systemName: "arrow.down.left.and.arrow.up.right")

                    }.buttonStyle(.bordered).padding(10).tint(mapTypeStandard ? .blue : .white)
                }
                .safeAreaInset(edge: .bottom,alignment: .leading) {
                    HStack(spacing: 10){
                        Button(action:{
                            camera = .region(MKCoordinateRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200))
                        }){
                            
                                Image(systemName: "building")
                           
                        }.buttonStyle(.bordered).padding(10).tint(mapTypeStandard ? .blue : .white)
                        
//                        Button(action:{
//                            camera = .region(MKCoordinateRegion(center: yourLocation, latitudinalMeters: 200, longitudinalMeters: 200))
//                        }){
//                            
//                                Image(systemName: "figure")
//
//                        }.buttonStyle(.bordered).padding(.trailing,10).tint(mapTypeStandard ? .blue : .white)
                        
                        Button(action:{
                            mapTypeStandard.toggle()
                        }){
                            
                                Image(systemName: "map")

                        }.buttonStyle(.bordered).padding(.trailing,10).tint(mapTypeStandard ? .blue : .white)
                        
                    }
                }.mapStyle(mapTypeStandard ? .standard : .imagery)
            }
    }
    .padding(.horizontal)
    }
    
    func openInAppleMaps(lat:Double,long:Double, placeName:String){
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let placemark = MKPlacemark(coordinate: coordinate)
    
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps()
    }
}


//#Preview {
//    MapView(doctorName)
//}
