//
//  CombinedView.swift
//  gammalighttherapy
//
//  Created by Tamilarasan on 11/10/24.
//

import SwiftUI

struct CombinedView: View {
    @Binding var isCombined: Bool
    var isDisabled: Bool
    let audioManager = AudioManager()
    let flashLightManager = FlashLightManager()
    let hapticManager = HapticManager()
    
    var body: some View {
        Button(action: {
            isCombined.toggle()
            if isCombined {
                flashLightManager.startFlashing()
                hapticManager.playHapticAt40Hz()
                audioManager.playSound()
            } else {
                flashLightManager.stopFlashing()
                hapticManager.stopHaptic()
                audioManager.stopSound()
            }
        }) {
            Image(isCombined ? "competence" : "competence-off")
                .resizable()
                .opacity(isDisabled ? 0.5 : 1.0)
                .frame(width: 32, height: 32)
                .padding()
        }
        .disabled(isDisabled)
    }
}

#Preview {
    CombinedView(isCombined: .constant(false), isDisabled: false)
}
