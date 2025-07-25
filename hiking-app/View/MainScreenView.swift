import SwiftUI

struct MainScreenView: View {
    @State private var tabSelection: Int = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            Text("home").tabItem {
                Image(systemName: "house")
                Text("Home")
                    .tag(1)
            }
            Text("map").tabItem {
                Image(systemName: "map")
                Text("map")
                    .tag(2)
            }
            Text("list").tabItem {
                Image(systemName: "location")
                Text("list")
                    .tag(3)
            }
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(tabSelection: $tabSelection )
        }
    }
}

#Preview {
    MainScreenView()
}
