import Foundation
import Combine
import CoreLocation

class TrackingViewModel: ObservableObject {
    @Published var distance: Double = 0.0
    @Published var elevationGain: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    private var startTrackingTime: Date?
    
    init() {
        LocationManager.shared.$recordedLocation
            .sink { [weak self] locations in
                self?.calculateStats(from: locations)
            }
            .store(in: &cancellables)
    }
    
    func start() {
        startTrackingTime = Date()
        LocationManager.shared.startTrackingLocation()
    }
    
    func stop() {
        LocationManager.shared.stopTrackingLocation()
    }
    
    private func calculateStats(from locations: [CLLocation]) {
        guard locations.count >= 2 else { return }
        
        distance = zip(locations, locations.dropFirst())
            .map { $0.distance(from: $1) }
            .reduce(0, +)
        
        elevationGain = zip(locations, locations.dropFirst())
            .map { max(0, $1.altitude - $0.altitude) }
            .reduce(0, +)
    }
}
