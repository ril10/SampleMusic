//
//  LabelTextFieldStyle.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 1/27/22.
//

import SwiftUI

struct LabelTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(Style.coralColor.rawValue), lineWidth: 1)
                                .foregroundColor(.clear)
            )
    }
}
