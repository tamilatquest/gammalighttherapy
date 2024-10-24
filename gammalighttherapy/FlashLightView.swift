//
//  FlashLightView.swift
//  gammalighttherapy
//
//  Created by Tamilarasan on 11/10/24.
//

import SwiftUI

struct FlashLightView: View {
    @Binding var isFlashing: Bool
    var isDisabled: Bool
    let fashLightManager = FlashLightManager()
    let hapticManager = HapticManager()
    
    var body: some View {
        Button(action: {
            isFlashing.toggle()
            if isFlashing {
                fashLightManager.startFlashing()
                hapticManager.playHapticAt40Hz()
            } else {
                fashLightManager.stopFlashing()
                hapticManager.stopHaptic()
            }
        }) {
            Image(systemName: isFlashing ? "lightbulb.fill" : "lightbulb")
                .resizable()
                .frame(width: 25, height: 32)
                .opacity(isDisabled ? 0.5 : 1.0)
                .foregroundColor(isFlashing ? .yellow : Color(hex: "f0f0f0"))
                .padding()
        }
        .disabled(isDisabled)
    }
}

#Preview {
    FlashLightView(isFlashing: .constant(false), isDisabled: false)
}
