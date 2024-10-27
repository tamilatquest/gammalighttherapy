import AVFoundation

class FlashLightManager {
    private var flashTimer: Timer?
    private let flashRate: Double = 1.0 / 40.0
    private var isTorchOn = false

    func startFlashing() {
        stopFlashing() // Ensure any previous timer is stopped
        flashTimer = Timer.scheduledTimer(timeInterval: flashRate, target: self, selector: #selector(toggleFlash), userInfo: nil, repeats: true)
    }

    @objc private func toggleFlash() {
        isTorchOn.toggle() // Toggle the state
        toggleTorch(on: isTorchOn)
    }

    func stopFlashing() {
        flashTimer?.invalidate()
        flashTimer = nil
        isTorchOn = false // Reset the state to ensure torch stays off
        toggleTorch(on: false) // Ensure torch is off
    }

    private func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            if on {
                try device.setTorchModeOn(level: 1.0)
            } else {
                device.torchMode = .off
            }
            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used: \(error)")
        }
    }
}
