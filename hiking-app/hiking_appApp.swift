import SwiftUI

@main
struct hiking_appApp: App {
    @State private var tabSelection: TabModel = .home
    
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                TabView(selection: $tabSelection) {
                    MainScreenView()
                        .tag(TabModel.home)
                    MapView()
                        .tag(TabModel.map)
                    UserLocationMapView()
                        .tag(TabModel.profile)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)
                
                CustomTabBar(tabSelection: $tabSelection)
            }
        }
    }
}
