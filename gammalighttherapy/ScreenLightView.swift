//
//  ScreenLightView.swift
//  gammalighttherapy
//
//  Created by Tamilarasan on 17/10/24.
//

import SwiftUI

struct ScreenLightView: View {
    @Binding var isScreenPlaying: Bool
    var isDisabled: Bool
    let toggleScreenFlickering: () -> Void

    var body: some View {
        Button(action: {
            isScreenPlaying.toggle()
            toggleScreenFlickering()
        }) {
            Image(isScreenPlaying ? "brightness" : "brightness-off")
                .resizable()
                .opacity(isDisabled ? 0.5 : 1.0)
                .frame(width: 32, height: 32)
                .padding()
        }
        .disabled(isDisabled)
    }
}

#Preview {
    ScreenLightView(isScreenPlaying: .constant(false), isDisabled: false, toggleScreenFlickering: {})
}
