import Foundation

enum TabModel: String, CaseIterable {
    case home = "home"
    case map = "map"
    case profile = "profile"
    
    var systemImageName: String {
        switch self {
        case .home:
            return "house"
        case .map:
            return "map"
        case .profile:
            return "person.circle"
        }
    }
}
