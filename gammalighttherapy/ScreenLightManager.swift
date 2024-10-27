import SwiftUI
import AVFoundation
import UIKit

class ScreenLightManager {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    func getScreenRefreshRate() -> Double {
        let screen = UIScreen.main
        return Double(screen.maximumFramesPerSecond)
    }

    func getVideoFileForRefreshRate() -> String {
//        let refreshRate = getScreenRefreshRate()
//        return refreshRate < 60 ? "30FPS_AV" : "120Hz_AV"
        return "30Hz_AV"
    }

    func playVideo(on view: UIView) {
        let videoFile = getVideoFileForRefreshRate()

        guard let videoURL = Bundle.main.url(forResource: videoFile, withExtension: "mp4") else {
            print("Video file not found")
            return
        }

        // Create and configure AVPlayer
        player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)

        // Set the frame of the playerLayer to match the view's bounds
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspectFill

        // Add playerLayer to the view's layer hierarchy
        view.layer.addSublayer(playerLayer!)

        // Add observer to loop video when it ends
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)

        // Play the video
        player?.play()
    }

    func updateLayerFrame(for view: UIView) {
        playerLayer?.frame = view.bounds
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        player?.seek(to: .zero)
        player?.play()
    }

    func stopVideo() {
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        
        NotificationCenter.default.removeObserver(self,
                                                  name: .AVPlayerItemDidPlayToEndTime,
                                                  object: player?.currentItem)
    }
}
