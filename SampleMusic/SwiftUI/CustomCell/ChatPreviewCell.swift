//
//  ChatPreviewCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/25/22.
//

import SwiftUI

struct ChatPreviewCell: View {
    @SwiftUI.State var lastMessage: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CustomImageView(imageWidth: 80.0, imageHeight: 80.0)
                Text(lastMessage)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ChatPreviewCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatPreviewCell(lastMessage: "Comrade")
    }
}
