//
//  RadioButton.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 1/28/22.
//

import SwiftUI

struct RadioButton: View {
    private var isActive: Bool = false
    private let completion: ((String) -> Void)?
    private var label: String = ""
    
    public init(
        isActive: Bool,
        label: String,
        completion: ((String) -> Void)?
    ) {
        self.isActive = isActive
        self.label = label
        self.completion = completion
    }
    var body: some View {
        Button(action:{
            self.completion?(label)
        }) {
            HStack(alignment: .center) {
                Image(systemName: self.isActive ? Icons.radioOn.rawValue : Icons.circle.rawValue)
                    .clipShape(Circle())
                    .foregroundColor(Color.black)
                Text(label)
                    .font(Font.system(size: 20))
            }.foregroundColor(Color.black)
        }
        .foregroundColor(Color.white)
    }
}

struct TestRadioButton: View {
    @SwiftUI.State var type = ""
    var body: some View {
        HStack {
            RadioButton(
                isActive: $type.wrappedValue == "User" ? true : false,
                label: "User",
                completion: { type in
                    self.type = type
                }
            )
            RadioButton(
                isActive: $type.wrappedValue == "Seller" ? true : false,
                label: "Seller",
                completion: { type in
                    self.type = type
                }
            )
        }
    }
}

struct RadioButton_Previews: PreviewProvider {
    static var previews: some View {
        TestRadioButton()
    }
}
