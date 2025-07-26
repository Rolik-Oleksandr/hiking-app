import SwiftUI

struct CustomTabBar: View {
    @Binding var tabSelection: TabModel

    var body: some View {
        let iconHeight: CGFloat = 60.0
        
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
            
            HStack(spacing: 0.0) {
                ForEach(TabModel.allCases, id: \.self) { tab in
                    let isCurrent = tabSelection == tab

                    Button {
                        withAnimation(.spring(response: 0.6,
                                              dampingFraction: 0.7,
                                              blendDuration: 0.7)) {
                            tabSelection = tab
                        }
                    } label: {
                        VStack(spacing: 2.0) {
                            Image(systemName: tab.systemImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .aspectRatio(
                                    isCurrent ? 0.5 : 0.7,
                                    contentMode: .fit)
                                .frame(
                                    width: isCurrent ? 60.0 : 35.0,
                                    height: isCurrent ? 60.0 : 35.0
                                )
                                .background {
                                    if isCurrent {
                                        Circle()
                                            .fill(Color.red.gradient)
                                    }
                                }
                                .offset(y: isCurrent ? -iconHeight/2 : 0)
                        
                            if !isCurrent {
                                Text(tab.rawValue)
                                    .font(.caption)
                                    .fontDesign(.rounded)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(isCurrent ? Color.white : Color.gray)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .frame(maxHeight : 80.0)
        .background(Color.red)
    }
}

#Preview {
    MainScreenView()
}
