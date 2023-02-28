//
//  PulsingView.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/28/23.
//

import SwiftUI

/// View with pulsing animation.
///
/// - Parameters:
///   - diameter: A `CGFloat` that determines the diameter of the animation.
///   - lineWidth: A `CGFloat` that determines the width of the animations.
struct PulsingView: View {
    var diameter: CGFloat = 80
    var lineWidth: CGFloat = 2
    @State var animate = false
    
    var body: some View {
        ZStack {
            Circle().stroke(Color(uiColor: UIColor.gray).opacity(animate ? 0 : 1), lineWidth: lineWidth).frame(width: diameter, height: diameter).scaleEffect(animate ? 1 : 0)
            Circle().stroke(Color(uiColor: UIColor.gray).opacity(animate ? 0 : 1), lineWidth: lineWidth).frame(width: diameter * 0.75, height: diameter * 0.75).scaleEffect(animate ? 1 : 0)
            Circle().stroke(Color(uiColor: UIColor.gray).opacity(animate ? 0 : 1), lineWidth: lineWidth).frame(width: diameter * 0.45, height: diameter * 0.45).scaleEffect(animate ? 1 : 0)
            Circle().stroke(Color(uiColor: UIColor.gray), lineWidth: lineWidth).frame(width: 0, height: 0)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                animate.toggle()
            }
        }
    }
}
