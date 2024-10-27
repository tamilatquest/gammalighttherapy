//
//  FlashLightView.swift
//  gammalighttherapy
//
//  Created by Tamilarasan on 11/10/24.
//

import SwiftUI

struct FlashLightView: View {
    @StateObject var flashLightManager = FlashLightManager()
    let hapticManager = HapticManager()
    let audioManager = AudioManager()
    
    var body: some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "d3d3d3"))
        .onAppear {
            flashLightManager.startFlashing()
            hapticManager.playHapticAt40Hz()
            audioManager.playSound()
        }
        .onDisappear {
            flashLightManager.stopFlashing()
            hapticManager.stopHaptic()
            audioManager.stopSound()
        }
    }
}

#Preview {
    FlashLightView()
}
