import AVFoundation

class FlashLightManager {
    private var flashTimer: DispatchSourceTimer?
    private let flashRate: Double = 1.0 / 40.0
    private var isFlashlightOn = false

    // Starts the flashlight flickering at 40Hz
    func startFlashing() {
        if flashTimer == nil {
            flashTimer = DispatchSource.makeTimerSource()
            flashTimer?.schedule(deadline: .now(), repeating: flashRate)
            flashTimer?.setEventHandler { [weak self] in
                self?.toggleTorch()
            }
            flashTimer?.activate()
        }
    }

    // Stops the flashing and ensures the flashlight is turned off
    func stopFlashing() {
        if isFlashlightOn {
            toggleTorch(on: false) // Ensure the flashlight is off
        }

        // Safely cancel and release the timer
        if let timer = flashTimer {
            timer.cancel()
            flashTimer = nil
        }
    }

    // Toggles the torch on and off
    private func toggleTorch(on: Bool? = nil) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }

        do {
            try device.lockForConfiguration()

            if let shouldTurnOn = on {
                device.torchMode = shouldTurnOn ? .on : .off
                if shouldTurnOn {
                    try device.setTorchModeOn(level: 1.0) // Set max brightness
                }
                isFlashlightOn = shouldTurnOn
            } else {
                isFlashlightOn.toggle()
                device.torchMode = isFlashlightOn ? .on : .off
                if isFlashlightOn {
                    try device.setTorchModeOn(level: 1.0)
                }
            }

            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used: \(error)")
        }
    }
}
