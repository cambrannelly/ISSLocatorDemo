//
//  Response.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/24/23.
//

import Foundation

/// Holds result of network call.
public enum Response<T> {
    case success(T)
    case error(Error)
}
