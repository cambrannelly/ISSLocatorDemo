//
//  PulsingView.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/28/23.
//

import SwiftUI

/// View with pulsing animation.
struct PulsingView: View {
    @State var animate = false
    
    var body: some View {
        ZStack {
            Circle().stroke(Color.gray.opacity(animate ? 0 : 1)).frame(width: 60, height: 100).scaleEffect(animate ? 1 : 0)
            Circle().stroke(Color.gray.opacity(animate ? 0 : 1)).frame(width: 40, height: 80).scaleEffect(animate ? 1 : 0)
            Circle().stroke(Color.gray.opacity(animate ? 0 : 1)).frame(width: 20, height: 50).scaleEffect(animate ? 1 : 0)
            Circle().stroke(Color.gray).frame(width: 0, height: 0)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                animate.toggle()
            }
        }
    }
}
