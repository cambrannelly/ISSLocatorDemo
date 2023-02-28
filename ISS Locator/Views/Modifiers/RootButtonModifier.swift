//
//  RootButtonModifier.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/27/23.
//

import Foundation
import SwiftUI

struct RootButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .frame(width: 100, height: 50)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 7)
      }
}

extension View {
    func rootButtonModifier() -> some View {
        modifier(RootButtonModifier())
    }
}
