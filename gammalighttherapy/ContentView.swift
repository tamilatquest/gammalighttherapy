import SwiftUI
import AVFoundation

struct FlashingView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                FlashLightView()
                    .tabItem {
                        CustomTabItem(title: "Flash", iconName: "flashlight.on.fill", isSelected: selectedTab == 1)
                    }
                ScreenLightView()
                    .tabItem {
                        CustomTabItem(title: "Screen", iconName: "doc.plaintext.fill", isSelected: selectedTab == 0)
                    }
            }
            .accentColor(.blue)
            .onAppear(perform: {
                UITabBar.appearance().unselectedItemTintColor = .darkGray
            })
        }
        .background(.blue)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CustomTabItem: View {
    let title: String
    let iconName: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? .white : .blue)
                .padding(10)
            
            Text(title)
        }
        .padding(5)
    }
}

struct ContentView: View {
    var body: some View {
        FlashingView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
