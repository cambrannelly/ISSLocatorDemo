//
//  MKMarker.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/26/23.
//

import Foundation
import MapKit

/// Data model for map annotations within MapView.
///
/// - Parameters:
///   - coordinate: A `CLLocationCoordinate2D` containing coordinates of map annotation.
class MKMarker: NSObject, MKAnnotation {
    // MARK: Properties
    
    dynamic var coordinate: CLLocationCoordinate2D
    
    // MARK: Initializer
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
