//
//  ScreenLightView.swift
//  gammalighttherapy
//
//  Created by Tamilarasan on 17/10/24.
//

import SwiftUI

struct ScreenLightView: View {
    let screenLightManager = ScreenLightManager()

    var body: some View {
        ZStack {
            VideoPlayerView()
                .edgesIgnoringSafeArea(.all)
        }
        .onAppear {
            screenLightManager.playVideo(on: UIView())
        }
        .onDisappear {
            screenLightManager.stopVideo()
        }
        
    }
}

#Preview {
    ScreenLightView()
}
