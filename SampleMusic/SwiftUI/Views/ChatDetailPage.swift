//
//  ChatDetailPage.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/25/22.
//

import SwiftUI

struct ChatDetailPage: View {
    @SwiftUI.State var text: String = ""
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center) {
                HStack {
                    TextField("Type a message", text: $text)
                        .frame(width: .infinity, height: 10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1)
                        )
                        .foregroundColor(.black)
                    Button(
                        action: {},
                        label: {
                            Image(systemName: Icons.send.rawValue)
                                .resizable()
                                .frame(width: 25, height: 25)
                        })
                }.padding()
            }.frame(width: .infinity, height: 120)
                .background(Color(Style.coralColor.rawValue))
        }.ignoresSafeArea()
    }
}

struct ChatDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailPage()
    }
}
