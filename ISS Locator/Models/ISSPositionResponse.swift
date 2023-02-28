//
//  ISSPositionResponse.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/24/23.
//

import Foundation

/// Data model dictating current location of ISS Satelite .
///
/// - Parameters:
///   - position: A `ISSPosition` containing coordiantes for current position of satelite.
///   - timestamp: A `Date` dictating when the current position was received.
///   - message: A `String` dictating the status of the current position.
class ISSPositionResponse: Codable {
    // MARK: Properties
    
    let position: ISSPosition
    let timestamp: Date
    let message: String
    
    // MARK: CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case position = "iss_position"
        case timestamp
        case message
    }
}
