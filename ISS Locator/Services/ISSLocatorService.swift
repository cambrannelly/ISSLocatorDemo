//
//  ISSLocatorService.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/24/23.
//

import Foundation

/// Service layer interface for fetching location of satelite.
class ISSLocatorService: ISSLocatorServiceable {
    // MARK: Properties
    
    private let issLocationEndpoint = "iss-now.json"
    private let baseUrl = "http://api.open-notify.org"
    private let networkProvider = NetworkProvider()
    private let decoder = JSONDecoder()
    
    // MARK: Networking Methods
    
    func getCurrentLocation(completion: @escaping (Response<ISSPositionResponse>) -> Void) {
        let url = "\(baseUrl)/\(issLocationEndpoint)"

        networkProvider.get(url) { data, response, error in
            if let data = data {
                do {
                    let decoded = try self.decoder.decode(ISSPositionResponse.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.error(error))
                }
            } else if let error = error {
                completion(.error(error))
            }
        }
    }
}
