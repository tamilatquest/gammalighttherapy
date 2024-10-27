import AVFoundation
import Combine
class FlashLightManager: ObservableObject {
    static let shared = FlashLightManager()
    private var flashTimer: Timer?
    private var isTorchOn = false
    
    private var flashRate: Double = 0.025 { // Set default flash rate to 0.025
        didSet {
            if flashRate < 0.025 { flashRate = 0.025 } // enforce a minimum rate
        }
    }

    // Change this to internal or public
    init() {} // Prevent external instantiation

    func startFlashing(with rate: Double? = nil) {
        if let rate = rate {
            self.flashRate = rate
        }
        stopFlashing() // Stop any existing flashing

        flashTimer = Timer.scheduledTimer(withTimeInterval: flashRate, repeats: true) { [weak self] _ in
            self?.toggleFlash()
        }
    }

    @objc private func toggleFlash() {
        isTorchOn.toggle()
        toggleTorch(on: isTorchOn)
    }

    func stopFlashing() {
        flashTimer?.invalidate()
        flashTimer = nil
        if isTorchOn {
            isTorchOn = false
            toggleTorch(on: false)
        }
    }

    private func toggleTorch(on: Bool) {
        // Ensure all torch manipulations are on the main thread
        DispatchQueue.main.async {
            guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
            do {
                try device.lockForConfiguration()
                device.torchMode = on ? .on : .off
                if on {
                    try device.setTorchModeOn(level: 1.0)
                }
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used: \(error.localizedDescription)")
            }
        }
    }
}
