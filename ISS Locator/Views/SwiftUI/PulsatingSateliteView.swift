//
//  PulsatingSateliteView.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/27/23.
//

import Foundation
import SwiftUI

/// View with satelite image with pulsing animation.
struct PulsatingSateliteView: View {
    var body: some View {
        ZStack {
            PulsingView()
            Image("satelite")
        }
    }
}
