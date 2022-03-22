//
//  TextStyle.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/22/22.
//

import SwiftUI

struct CustomTextStyle: View {
    private var text: String = ""
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(Font.custom(Style.fontTitleHeavy.rawValue, size: 20))
        }
    }
}

struct CustomTextStyle_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextStyle(text: "Hello")
    }
}
