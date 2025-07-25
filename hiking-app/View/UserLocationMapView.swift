import SwiftUI
import MapboxMaps

struct UserLocationMapView: View {
    @StateObject private var locationManager = LocationManager()
    let center = CLLocationCoordinate2D(latitude: 50.37, longitude: 30.27)
    
    var body: some View {
        MapReader { proxy in
            Map(initialViewport: .camera(center: center, zoom: 4, bearing: 0, pitch:0)) {
                Puck2D(bearing: .heading)
            }
            .mapStyle(.outdoors)
            .ignoresSafeArea(edges: .all)
            .onAppear {
                proxy.location?.override(
                    locationProvider: locationManager.$location
                        .compactMap { $0 }
                        .map { [$0] }
                        .eraseToSignal(),
                    headingProvider: locationManager.$heading.eraseToSignal()
                )
            }
        }
    }
}

#Preview {
    UserLocationMapView()
}
