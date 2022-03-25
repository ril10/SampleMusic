//
//  ChatPage.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/25/22.
//

import SwiftUI

struct ChatPage: View {
    var body: some View {
        List {
            ChatPreviewCell(lastMessage: "Hello world")
        }.frame(width: .infinity, height: .infinity)
    }
}

struct ChatPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatPage()
    }
}
