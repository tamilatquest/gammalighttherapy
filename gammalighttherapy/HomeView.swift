//
//  HomeView.swift
//  gammalighttherapy
//
//  Created by Tamilarasan on 27/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
        }
    }
}

#Preview {
    HomeView()
}
