//
//  ISSLocationHUD.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/25/23.
//

import CoreLocation
import SwiftUI

/// HUD view for display longitude and latitude of location .
///
/// - Parameters:
///   - coordinate: A `CLLocationCoordinate2D` containing coordinate of current location to display.
struct ISSLocationHUD: View {
    // MARK: Properties
    
    var coordinate: CLLocationCoordinate2D?
    
    var body: some View {
        VStack {
            HStack {
                Text("Latitude: ")
                    .hudTextModifier()
                Spacer()
                if let latitude = coordinate?.latitude {
                    Text("\(latitude)")
                        .hudTextModifier()
                }
            }
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
            
            HStack {
                Text("Longitude: ")
                    .hudTextModifier()
                Spacer()
                if let longitude = coordinate?.longitude {
                    Text("\(longitude)")
                        .hudTextModifier()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
        }
    }
}
