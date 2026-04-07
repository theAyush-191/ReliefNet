import SwiftUI
import MapKit

struct MapView: View {
    let doctorName: String
    let lat: Double
    let long: Double
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    @State private var camera: MapCameraPosition = .automatic
    @State private var isStandardMap: Bool = true
    
    var body: some View {
        Map(position: $camera) {
            // Native Marker with a medical touch
            Marker(doctorName, systemImage: "cross.case.fill", coordinate: location)
                .tint(.purple)
        }
        .mapStyle(isStandardMap ? .standard(elevation: .realistic) : .imagery(elevation: .realistic))
        .overlay(alignment: .top) {
            // Top Gradient for readability
            LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .top, endPoint: .bottom)
                .frame(height: 100)
                .allowsHitTesting(false)
        }
        .safeAreaInset(edge: .bottom) {
            // Floating Glassmorphism Control Center
            HStack(spacing: 20) {
                mapActionIcon(systemName: isStandardMap ? "globe.americas.fill" : "map.fill") {
                    withAnimation(.spring()) { isStandardMap.toggle() }
                }
                
                Button(action: openInAppleMaps) {
                    HStack {
                        Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                        Text("Directions")
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(color: .purple.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                
                mapActionIcon(systemName: "scope") {
                    withAnimation(.snappy) {
                        camera = .region(MKCoordinateRegion(center: location, latitudinalMeters: 400, longitudinalMeters: 400))
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(.white.opacity(0.2), lineWidth: 1))
            .padding(.bottom, 20)
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
        }
        .cornerRadius(24) // Softer corners for the card look
    }
    
    // Minimalist Circular Action Button
    @ViewBuilder
    func mapActionIcon(systemName: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 20))
                .foregroundColor(.primary)
                .frame(width: 44, height: 44)
                .background(.white.opacity(0.5))
                .clipShape(Circle())
        }
    }

    func openInAppleMaps() {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: location))
        mapItem.name = doctorName
        mapItem.openInMaps()
    }
}
