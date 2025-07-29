import Foundation
import SwiftUI

enum TabModel: String, Hashable, CaseIterable {
    case home = "home"
    case map = "map"
    case route = "route"
    case profile = "profile"
    
    var systemImageName: String {
        switch self {
        case .home:
            return "house"
        case .map:
            return "map"
        case .route:
            return "point.bottomleft.forward.to.point.topright.scurvepath"
        case .profile:
            return "person.circle"
        }
    }
}
