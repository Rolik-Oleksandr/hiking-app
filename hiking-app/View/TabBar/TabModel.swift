import Foundation
import SwiftUI

enum TabModel: String, Hashable, CaseIterable {
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
