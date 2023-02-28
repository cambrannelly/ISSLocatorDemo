//
//  ISSLocatorViewRepresentable.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/26/23.
//

import Foundation
import SwiftUI

struct ISSLocatorViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewType = ISSLocatorViewController
    
    func makeUIViewController(context: Context) -> UIViewType {
        return ISSLocatorViewController(viewModel: ISSLocatorViewModel(service: ISSLocatorService()))
    }
    
    func updateUIViewController(_ uiViewController: UIViewType, context: Context) {
        //
    }
}
