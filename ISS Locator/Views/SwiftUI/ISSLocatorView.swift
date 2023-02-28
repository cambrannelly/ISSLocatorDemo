//
//  ContentView.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/24/23.
//

import MapKit
import SwiftUI

/// Shows location of ISS Satelite over a Map.
///
/// - Parameters:
///   - viewModel: A `ISSLocatorViewModel`.
struct ISSLocatorView: View {
    // MARK: Properties
    
    @ObservedObject var viewModel: ISSLocatorViewModel
    @State var animate = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            /*
             NOTE: Setting the map's annotation using a @Published property found in the observed ISSLocatorViewModel seems to cause the UI Warning:
             "Publishing changes from within view updates is not allowed, this will cause undefined behavior."
             After extensive research found in these links:
             https://developer.apple.com/forums/thread/711899
             https://developer.apple.com/forums/thread/719701
             https://developer.apple.com/forums/thread/718697
             It seems this could possibly be a bug that has been filed to Apple already. This doesn't occur when using MapView in UIKit
            */
            
            Map(coordinateRegion: $viewModel.region,
                annotationItems: viewModel.currentMarkers)
            { marker in
                MapAnnotation(coordinate: marker.coordinate) {
                    PulsatingSateliteView()
                }
            }
            .allowsHitTesting(false)
            
            HStack {
                Spacer()
                ISSLocationHUD(coordinate: viewModel.currentPosition?.coordinate)
                    .frame(width: 200, height: 75)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 12))
            }
        }
        .errorAlert(error: $viewModel.error)
        .task {
            viewModel.startTrackingLocation()
        }
    }
}
