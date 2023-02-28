//
//  View+Extensions.swift
//  ISS Locator
//
//  Created by Cam Brannelly on 2/28/23.
//

import SwiftUI

extension View {
    /// Shows an alert with an error.
    ///
    /// - Parameters:
    ///   - error: A `Binding` to an Error.
    ///   - buttonTitle: A `String` to display as the button title.
    ///   - action: A closure to execute when pressing the button.
    ///   - retryAction: An optional closure with a retry action.
    func errorAlert(
        error: Binding<Error?>,
        buttonTitle: String = "Ok",
        action: @escaping () -> Void = {},
        retryAction: (() -> Void)? = nil
    ) -> some View {
        return alert("Error", isPresented: .constant(error.wrappedValue != nil), presenting: error) { _ in
            HStack {
                if let retryAction {
                    Button("Retry") {
                        error.wrappedValue = nil
                        retryAction()
                    }
                }

                Button(buttonTitle) {
                    error.wrappedValue = nil
                    action()
                }
            }
        } message: { _ in
            Text(error.wrappedValue?.localizedDescription ?? "")
        }
    }
}
