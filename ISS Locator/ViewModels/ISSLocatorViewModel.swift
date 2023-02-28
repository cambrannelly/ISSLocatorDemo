//
//  ISSLocatorViewModel.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/24/23.
//

import CoreLocation
import MapKit
import SwiftUI

class ISSLocatorViewModel: ObservableObject {
    @Published var error: Error?
    @Published var currentPosition: Marker?
    
    private var isFetchingLocation = false
    private var timer: Timer?
    private let service: ISSLocatorServiceable
    private var meterSpan: Double = 1000000
    
    var region: MKCoordinateRegion
    
    var currentMarkers: [Marker] {
        if let currentPosition = currentPosition {
            return [currentPosition]
        }
        return []
    }
    
    init(service: ISSLocatorServiceable) {
        self.service = service
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3346, longitude: 122.0090), latitudinalMeters: meterSpan, longitudinalMeters: meterSpan)
    }
    
    func startTrackingLocation() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            guard !self.isFetchingLocation else { return }
            self.getISSLocation()
        }
    }
    
    func getISSLocation() {
        isFetchingLocation = true
        error = nil
        service.getCurrentLocation { response in
            self.isFetchingLocation = false
            switch response {
            case .success(let positionResponse):
                Task {
                    await self.setNew(position: positionResponse.position)
                }
                
            case .error(let error):
                self.timer?.invalidate()
                Task {
                    await self.set(error: error)
                }
            }
        }
    }
    
    // MARK: Helper Methods
    
    @MainActor
    private func setNew(position: ISSPosition) {
        guard let coordinates = self.getCoordinates(from: position) else { return }
        withAnimation {
            self.region = MKCoordinateRegion(center: coordinates, latitudinalMeters: self.meterSpan, longitudinalMeters: self.meterSpan)
            if self.currentPosition == nil {
                self.currentPosition = Marker(coordinate: coordinates)
            } else {
                self.currentPosition?.coordinate = coordinates
            }
        }
    }
    
    @MainActor
    private func set(error: Error) {
        self.error = error
    }
    
    func getCoordinates(from position: ISSPosition) -> CLLocationCoordinate2D? {
        guard let latitude = Double(position.latitude), let longitude = Double(position.longitude) else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
