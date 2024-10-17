//
//  ScreenLightView.swift
//  gammalighttherapy
//
//  Created by Tamilarasan on 17/10/24.
//

import SwiftUI

struct ScreenLightView: View {
    @Binding var isScreenPlaying: Bool
    let toggleScreenFlickering: () -> Void

    var body: some View {
        Button(action: {
            isScreenPlaying.toggle()
            toggleScreenFlickering()
        }) {
            Image(isScreenPlaying ? "brightness" : "brightness-off")
                .resizable()
                .frame(width: 32, height: 32)
                .padding()
        }
    }
}

#Preview {
    ScreenLightView(isScreenPlaying: .constant(false), toggleScreenFlickering: {})
}
