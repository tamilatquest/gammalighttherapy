import AVFoundation

class FlashLightManager {
    private var flashTimer: Timer?
    private let flashRate: Double = 1.0 / 40.0
    private var isTorchOn = false
    private let controlQueue = DispatchQueue(label: "com.flashLight.controlQueue") // For synchronized control

    func startFlashing() {
        stopFlashing() // Stop any existing flash before starting
        flashTimer = Timer.scheduledTimer(timeInterval: flashRate, target: self, selector: #selector(toggleFlash), userInfo: nil, repeats: true)
    }

    @objc private func toggleFlash() {
        controlQueue.sync { // Synchronize torch access
            isTorchOn.toggle() // Toggle the torch state
            toggleTorch(on: isTorchOn)
        }
    }

    func stopFlashing() {
        flashTimer?.invalidate() // Stop the timer
        flashTimer = nil

        controlQueue.sync { // Force turn off the torch in a synchronized manner
            isTorchOn = false
            toggleTorch(on: false) // Ensure torch is off
        }
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
