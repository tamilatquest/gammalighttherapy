import SwiftUI
import AVFoundation

class AudioManager {
    @State private var audioPlayerNode: AVAudioPlayerNode?
    private var audioEngine = AVAudioEngine()

    private func configureAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }

    func playSound() {
        configureAudioSession()

        guard let audioFileURL = Bundle.main.url(forResource: "40hz", withExtension: "wav") else {
            print("Audio file not found")
            return
        }

        do {
            let audioFile = try AVAudioFile(forReading: audioFileURL)

            let playerNode = AVAudioPlayerNode()
            audioEngine.attach(playerNode)

            audioEngine.connect(playerNode, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)

            try audioEngine.start()

            let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: AVAudioFrameCount(audioFile.length))!
            try audioFile.read(into: buffer)

            playerNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)

            playerNode.play()

            self.audioPlayerNode = playerNode
        } catch {
            print("Failed to play sound: \(error)")
        }
    }

    func stopSound() {
        audioPlayerNode?.stop()
        audioEngine.stop()
    }
}
