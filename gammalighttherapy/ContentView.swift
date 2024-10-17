import SwiftUI
import AVFoundation

struct FlashingView: View {
    @State private var isScreenPlaying = false
    @State private var isScreenFlickering = false
    @State private var screenFlashTimer: Timer?
    private let screenFlashRate: Double = 1.0 / 40.0
    
    let screenLightManager = ScreenLightManager()
    
    var body: some View {
        ZStack {
            Color(hex: "212121").edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                if isScreenPlaying {
                    VideoPlayerView(isScreenPlaying: $isScreenPlaying)
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Full width and height
                        .edgesIgnoringSafeArea(.all) // Ignore safe areas
                } else {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                }

                Spacer()
                
                HStack {
                    FlashLightView()
                    AudioView()
                    CombinedView()
                    ScreenLightView(isScreenPlaying: $isScreenPlaying, toggleScreenFlickering: toggleScreenFlickering)
                }
                .frame(maxWidth: .infinity) // Make sure the HStack stretches full width
                .background(Color(hex: "2f2f2f"))
                .cornerRadius(10)
                
            }
        }
        .onAppear {
            if isScreenPlaying {
                screenLightManager.playVideo(on: UIView())
            }
        }
        .onDisappear {
            stopFlickering() // Stop flickering when view disappears
        }
    }

    private func startFlickering() {
        isScreenFlickering = true
        screenLightManager.playVideo(on: UIView()) // Ensure the video plays
    }

    private func stopFlickering() {
        screenLightManager.stopVideo() // Stop video playback
    }

    private func toggleScreenFlickering() {
        if isScreenPlaying {
            startFlickering()
        } else {
            stopFlickering()
        }
    }
}

struct ContentView: View {
    var body: some View {
        FlashingView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "212121"))
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
