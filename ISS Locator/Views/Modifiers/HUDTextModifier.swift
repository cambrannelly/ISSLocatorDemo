//
//  HUDTextModifier.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/27/23.
//

import SwiftUI

struct HUDTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.system(size: 14))
      }
}

extension View {
    func hudTextModifier() -> some View {
        modifier(HUDTextModifier())
    }
}
