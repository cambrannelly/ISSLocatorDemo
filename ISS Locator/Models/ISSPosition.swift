//
//  ISSPosition.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/24/23.
//

import Foundation
/// Data model dictating current latitude and longitude of ISS Satelite .
///
/// - Parameters:
///   - id: A `UUID` for the model.
///   - latitude: A `String` of the current latitude of the satelite.
///   - longitude: A `String` of the current longitude of the satelite.
class ISSPosition: Codable {
    let id = UUID()
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
