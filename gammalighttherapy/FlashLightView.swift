//
//  FlashLightView.swift
//  gammalighttherapy
//
//  Created by Tamilarasan on 11/10/24.
//

import SwiftUI

struct FlashLightView: View {
    @State var isFlashing: Bool = true
    let fashLightManager = FlashLightManager()
    let hapticManager = HapticManager()
    
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
            fashLightManager.startFlashing()
            hapticManager.playHapticAt40Hz()
        }
        .onDisappear {
            fashLightManager.stopFlashing()
            hapticManager.stopHaptic()
        }
    }
}

#Preview {
    FlashLightView()
}
