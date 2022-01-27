//
//  CoralButton.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 1/27/22.
//

import SwiftUI

struct CoralButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color(Style.coralColor.rawValue))
            .foregroundColor(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .shadow(radius: 10.0)
    }
}
