//
//  RootView.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/26/23.
//

import Foundation
import SwiftUI

/// Root view of the App.
struct RootView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("ISS\nLOCATOR")
                        .font(.system(size: 35, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    Spacer()
                }
                
                RotatingSatelite()
                
                VStack(spacing: 30) {
                    NavigationLink {
                        ISSLocatorView(
                            viewModel: ISSLocatorViewModel(service: ISSLocatorService())
                        )
                        .ignoresSafeArea()
                    } label: {
                        Text("SwiftUI")
                            .rootButtonModifier()
                    }
                    
                    NavigationLink {
                        ISSLocatorViewRepresentable()
                            .ignoresSafeArea()
                    } label: {
                        Text("UIKit")
                            .rootButtonModifier()
                    }
                }
            }
            .background(
                ZStack {
                    Image("sky")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    Image("earth")
                }
            )
        }
    }
}
