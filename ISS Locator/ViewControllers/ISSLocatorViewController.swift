//
//  ISSLocatorViewController.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/26/23.
//

import Combine
import MapKit
import UIKit

/// Shows location of ISS Satelite over a MapView .
///
/// - Parameters:
///   - viewModel: A `ISSLocatorViewModel`.
class ISSLocatorViewController: UIViewController {
    // MARK: Properties
    
    private let viewModel: ISSLocatorViewModel
    private var subscriptions: [AnyCancellable] = []
    private var currentLocation: MKMarker?
    private var longitudeLabel = UILabel()
    private var latitudeLabel = UILabel()
    private let mapView: MKMapView = .init()
    
    // MARK: Initializers
    
    required init(viewModel: ISSLocatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupHUD()
        setupObservers()
        viewModel.startTrackingLocation()
    }
    
    // MARK: Setup Methods
    
    private func setupObservers() {
        viewModel.$error.sink { [weak self] error in
            if let error = error {
                self?.display(error: error)
            }
        }
        .store(in: &subscriptions)
        
        viewModel.$currentPosition.sink { [weak self] location in
            if let location = location, let self = self {
                self.update(location: location)
            }
        }
        .store(in: &subscriptions)
    }
    
    private func setupHUD() {
        let hudView = UIView()
        hudView.backgroundColor = .white
        let font = UIFont.systemFont(ofSize: 15)
        
        latitudeLabel.textColor = .black
        latitudeLabel.font = font
        longitudeLabel.textColor = .black
        longitudeLabel.font = font
        
        let latitudeStack = UIStackView()
        latitudeStack.axis = .horizontal
        
        let latitudeDescriptionLabel = UILabel()
        latitudeDescriptionLabel.text = "Latitude"
        latitudeDescriptionLabel.textColor = .black
        latitudeDescriptionLabel.font = font
        
        let longitudeStack = UIStackView()
        longitudeStack.axis = .horizontal
        
        let longitudeDescriptionLabel = UILabel()
        longitudeDescriptionLabel.text = "Longitude"
        longitudeDescriptionLabel.textColor = .black
        longitudeDescriptionLabel.font = font
        
        longitudeStack.addArrangedSubview(longitudeDescriptionLabel)
        longitudeStack.addArrangedSubview(longitudeLabel)
        
        latitudeStack.addArrangedSubview(latitudeDescriptionLabel)
        latitudeStack.addArrangedSubview(latitudeLabel)
        
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        
        vStack.addArrangedSubview(latitudeStack)
        vStack.addArrangedSubview(longitudeStack)
        vStack.distribution = .fillEqually
        
        hudView.addSubview(vStack)
        
        hudView.addConstraints([
            vStack.topAnchor.constraint(equalTo: hudView.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: hudView.bottomAnchor),
            vStack.trailingAnchor.constraint(equalTo: hudView.trailingAnchor, constant: -12),
            vStack.leadingAnchor.constraint(equalTo: hudView.leadingAnchor, constant: 12)
        ])
        
        hudView.layer.masksToBounds = false
        hudView.layer.cornerRadius = 15
        hudView.layer.shadowColor = UIColor.black.cgColor
        hudView.layer.shadowOffset = CGSize(width: 3, height: 3)
        hudView.layer.shadowOpacity = 0.5
        hudView.layer.shadowRadius = 5
        
        hudView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hudView)
        
        view.addConstraints([
            hudView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            hudView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            hudView.widthAnchor.constraint(equalToConstant: 200),
            hudView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func setupMap() {
        mapView.delegate = self
        mapView.isUserInteractionEnabled = false
        mapView.register(SateliteAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        setMapConstraints()
    }
    
    private func setMapConstraints() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
    private func display(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
    
    private func update(location: Marker) {
        if currentLocation == nil {
            let newLocation = MKMarker(coordinate: location.coordinate)
            mapView.addAnnotation(newLocation)
            currentLocation = newLocation
        } else {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.currentLocation?.coordinate = location.coordinate
            }
        }
        longitudeLabel.text = "\(location.coordinate.longitude)"
        latitudeLabel.text = "\(location.coordinate.latitude)"
        mapView.setRegion(viewModel.region, animated: true)
    }
}

// MARK: Delegates

extension ISSLocatorViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKMarker else { return nil }
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom") {
            return annotationView
        } else {
            let annotationView = SateliteAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            return annotationView
        }
    }
}
