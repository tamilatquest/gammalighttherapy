import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    @Binding var isScreenPlaying: Bool
    var player: AVPlayer

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        
        // Create AVPlayerLayer to handle video display
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill // Fill the entire view
        controller.view.layer.addSublayer(playerLayer)

        // Hide playback controls
        playerLayer.player?.isMuted = true // Optional: Mute the video

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update frame of the playerLayer when the view changes
        if let layer = uiViewController.view.layer.sublayers?.first as? AVPlayerLayer {
            layer.frame = uiViewController.view.bounds // Set to fill the view
        }

        // Start/stop playback based on the isScreenPlaying state
        if isScreenPlaying {
            player.play()
        } else {
            player.pause()
        }
    }
}
