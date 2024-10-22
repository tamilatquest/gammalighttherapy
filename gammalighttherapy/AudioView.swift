//
//  AudioView.swift
//  gammalighttherapy
//
//  Created by Tamilarasan on 11/10/24.
//

import SwiftUI

struct AudioView: View {
    @Binding var isAudioPlaying: Bool
    var isDisabled: Bool
    let audioManager = AudioManager()
    
    var body: some View {
        Button(action: {
            isAudioPlaying.toggle()
            if isAudioPlaying {
                play40HzSound()
            } else {
                stopSound()
            }
        }) {
            Image(systemName: isAudioPlaying ? "speaker.fill" : "speaker.slash.fill")
                .resizable()
                .opacity(isDisabled ? 0.5 : 1.0)
                .frame(width: 32, height: 32)
                .foregroundColor(isAudioPlaying ? .blue : Color(hex: "f0f0f0"))
                .padding()
        }
        .disabled(isDisabled)
    }
    
    private func stopSound() {
        audioManager.stopSound()
    }

    private func play40HzSound() {
        audioManager.playSound()
    }
}

#Preview {
    AudioView(isAudioPlaying: .constant(false), isDisabled: false)
}

