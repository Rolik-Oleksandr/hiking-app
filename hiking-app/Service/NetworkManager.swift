import Foundation
import Apollo

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private(set) lazy var apollo: ApolloClient = {
        let url = URL(string: "")!
        return ApolloClient(url: url)
    }()
}
