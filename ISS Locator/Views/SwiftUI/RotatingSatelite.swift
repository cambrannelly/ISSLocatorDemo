//
//  RotatingSatelite.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/27/23.
//

import SwiftUI

/// View with satelite that rotates in a circle.
///
/// - Parameters:
///   - timer: A `Timer` to dictate speed of animation.
///   - diameter: A `CGFloat` diameter of the circle path the animation travels.
struct RotatingSatelite: View {
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    let diameter: CGFloat = 300.0
    @State private var angle: Double = .zero
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.clear, lineWidth: 1)
                .frame(width: diameter, height: diameter)
                .overlay(
                    Image("satelite")
                        .offset(x: diameter / 2)
                        .rotationEffect(.degrees(angle))
                )
        }
        .onReceive(timer) { _ in
            withAnimation {
                angle -= 1
            }
        }
    }
}
