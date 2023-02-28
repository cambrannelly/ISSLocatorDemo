//
//  ISSLocatorServiceable.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/24/23.
//

import Foundation

protocol ISSLocatorServiceable {
    func getCurrentLocation(completion: @escaping (Response<ISSPositionResponse>) -> Void)
}
