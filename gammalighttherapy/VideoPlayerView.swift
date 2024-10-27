import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @State var isScreenPlaying: Bool =  true
    @State private var player: AVPlayer?
    @State private var playerItem: AVPlayerItem?

    var body: some View {
        VStack {
            if let player = player {
                CustomVideoPlayer(isScreenPlaying: $isScreenPlaying, player: player)
                    .onAppear {
                        if isScreenPlaying {
                            player.play()
                        }
                    }
                    .onDisappear {
                        player.pause()
                    }
            } else {
                Text("Loading video...")
            }
        }
        .onAppear {
            loadVideo()
        }
        .onChange(of: isScreenPlaying) { playing in
            if playing {
                player?.play()
            } else {
                player?.pause()
            }
        }
    }
    
    private func loadVideo() {
        let videoFile = getVideoFileForRefreshRate()

        guard let videoURL = Bundle.main.url(forResource: videoFile, withExtension: "mp4") else {
            print("Video file not found")
            return
        }
        
        playerItem = AVPlayerItem(url: videoURL)
        player = AVPlayer(playerItem: playerItem)
        
        player?.actionAtItemEnd = .none
        
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerItem,
            queue: .main
        ) { [weak player] _ in
            player?.seek(to: .zero)
            player?.play()
        }
    }

    private func getScreenRefreshRate() -> Double {
        let screen = UIScreen.main
        return Double(screen.maximumFramesPerSecond)
    }

    private func getVideoFileForRefreshRate() -> String {
        let refreshRate = getScreenRefreshRate()
        return refreshRate < 60 ? "30FPS_AV" : "120Hz_AV"
    }
}
