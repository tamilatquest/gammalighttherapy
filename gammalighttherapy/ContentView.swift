import SwiftUI
import AVFoundation

struct FlashingView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ScreenLightView()
                    .tabItem {
                        CustomTabItem(title: "Screen", iconName: "lightbulb.fill")
                    }
                
                FlashLightView()
                    .tabItem {
                        CustomTabItem(title: "Flash", iconName: "flashlight.on.fill")
                    }
            }
        }
    }
}

struct CustomTabItem: View {
    let title: String
    let iconName: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 24))
            Text(title)
                .font(.system(size: 18, weight: .bold))
        }
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
