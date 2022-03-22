//
//  GrayButton.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/22/22.
//

import SwiftUI

struct GrayButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .imageScale(Image.Scale.large)
            .background(Color(UIColor(cgColor: UIColor.lightGray.cgColor)))
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .shadow(radius: 10.0)
    }
}
