//
//  SateliteAnnotationView.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/26/23.
//

import Foundation
import MapKit

/// Custom subclass of MKAnnotationView.
final class SateliteAnnotationView: MKAnnotationView {
    // MARK: Properties
    
    private var pulseLayers = [CAShapeLayer]()
    private var pulseArray = [CAShapeLayer]()
    
    // MARK: Initializers
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        canShowCallout = false
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupUI() {
        backgroundColor = .clear
        
        let view = UIImageView(image: UIImage(named: "satelite"))
        addSubview(view)
        
        view.frame = bounds
        createPulse()
    }
    
    private func createPulse() {
        let numberOfAnimations = 3
        for _ in 0..<numberOfAnimations {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: frame.size.width , startAngle: 0, endAngle: 2 * .pi , clockwise: true)
            let pulsatingLayer = CAShapeLayer()
            pulsatingLayer.path = circularPath.cgPath
            pulsatingLayer.lineWidth = 2.5
            pulsatingLayer.fillColor = UIColor.clear.cgColor
            pulsatingLayer.lineCap = CAShapeLayerLineCap.round
            pulsatingLayer.position = CGPoint(x: frame.size.width / 2.0, y: frame.size.width / 2.0)
            layer.addSublayer(pulsatingLayer)
            pulseArray.append(pulsatingLayer)
        }
        
        dispatchAnimations()
    }
    
    private func dispatchAnimations() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.animatePulsatingLayerAt(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                self.animatePulsatingLayerAt(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.animatePulsatingLayerAt(index: 2)
                })
            })
        })
    }
    
    private func animatePulsatingLayerAt(index: Int) {
        pulseArray[index].strokeColor = UIColor.darkGray.cgColor
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.9
        
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.fromValue = 0.9
        opacityAnimation.toValue = 0.0
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, opacityAnimation]
        groupAnimation.duration = 2.3
        groupAnimation.repeatCount = .greatestFiniteMagnitude
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        pulseArray[index].add(groupAnimation, forKey: "groupanimation")
    }
}
