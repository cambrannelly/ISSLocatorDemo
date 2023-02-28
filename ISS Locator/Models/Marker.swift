//
//  Marker.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/25/23.
//

import CoreLocation

/// Data model for map annotations within Map.
///
/// - Parameters:
///   - id: A `UUID` for the model.
///   - coordinate: A `CLLocationCoordinate2D` containing coordinates of map annotation.
struct Marker: Identifiable, Equatable {
    // MARK: Properties
    
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
    
    static func == (lhs: Marker, rhs: Marker) -> Bool {
        lhs.id == rhs.id
    }
}
