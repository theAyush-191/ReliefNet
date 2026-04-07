//
//  LocationPickerView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 07/04/26.
//
import SwiftUI
struct LocationPickerView: View {
    
    @EnvironmentObject var session: UserSession
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedCity = "Lucknow"
    @State private var selectedArea = "Gomti Nagar"
    
    let cities = ["Lucknow", "Delhi", "Mumbai"]
    
    let areas = [
        "Lucknow": ["Gomti Nagar", "Aliganj", "Indira Nagar"],
        "Delhi": ["Saket", "Dwarka"],
        "Mumbai": ["Andheri", "Bandra"]
    ]
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("Select Location")
                .font(.title2)
                .fontWeight(.bold)
            
            // City Picker
            Picker("City", selection: $selectedCity) {
                ForEach(cities, id: \.self) { city in
                    Text(city)
                }
            }
            .pickerStyle(.wheel)
            
            // Area Picker
            Picker("Area", selection: $selectedArea) {
                ForEach(areas[selectedCity] ?? [], id: \.self) { area in
                    Text(area)
                }
            }
            .pickerStyle(.wheel)
            
            Button("Confirm") {
//                $session.selectedLocation = AppLocation(
//                    city: selectedCity,
//                    area: selectedArea
//                )
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct AppLocation {
    var city: String
    var area: String
}

#Preview{
    LocationPickerView()
}
