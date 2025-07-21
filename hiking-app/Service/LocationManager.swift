import Foundation
import MapboxMaps
import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    @Published var location: Location = Location(coordinate: CLLocationCoordinate2D(latitude: 50.27, longitude: 30.31))
    @Published var heading: Heading = Heading(direction: 0, accuracy: 0)

    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let clLocation = locations.last else { return }

        DispatchQueue.main.async {
            self.location = Location(coordinate: clLocation.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.heading = Heading(direction: newHeading.trueHeading, accuracy: newHeading.headingAccuracy)
        }
    }
}
