import SwiftUI
import AVFoundation

struct FlashingView: View {
    @State private var isScreenPlaying = false
    @State private var isFlashing = false
    @State private var isAudioPlaying = false
    @State private var isCombined = false
    
    private var isFlashDisabled: Bool {
        isAudioPlaying || isScreenPlaying || isCombined
    }
    
    private var isAudiDisabled: Bool {
        isFlashing || isScreenPlaying || isCombined
    }
    
    private var isCombinedDisabled: Bool {
        isAudioPlaying || isScreenPlaying || isFlashing
    }
    
    private var isScreenDisabled: Bool {
        isAudioPlaying || isCombined || isFlashing
    }

    
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                } else {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                }

                Spacer()
                
                HStack {
                    FlashLightView(isFlashing: $isFlashing, isDisabled: isFlashDisabled)
                    AudioView(isAudioPlaying: $isAudioPlaying, isDisabled: isAudiDisabled)
                    CombinedView(isCombined: $isCombined, isDisabled: isCombinedDisabled )
                    ScreenLightView(isScreenPlaying: $isScreenPlaying, isDisabled: isScreenDisabled, toggleScreenFlickering: toggleScreenFlickering)
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
