//
//  ChatDetailCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/25/22.
//

import SwiftUI

struct ChatCell: View {
    @SwiftUI.State var message: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CustomImageView(imageWidth: 30.0, imageHeight: 30.0)
                Text(message)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ChatDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatCell(message: "Hello")
    }
}
