//
//  RecordPage.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/25/22.
//

import SwiftUI

struct RecordPage: View {
    @SwiftUI.State var sampleName = ""
    var body: some View {
        VStack(alignment: .leading) {
            CustomTextStyle(text: "1.Type Sample name:")
            TextField("Type sample name", text: $sampleName)
                .overlay(VStack{
                    Divider()
                        .offset(x: 0, y: 15)
                })
            CustomTextStyle(text: "2.Create your sample")
            VStack(alignment: .center) {
                Button(
                    action: {},
                    label: {
                        Image(systemName: Icons.mic.rawValue)
                            .resizable()
                            .frame(width: 35, height: 35)
                    })
                    .buttonStyle(GrayButton())
            }
        }
    }
}

struct RecordPage_Previews: PreviewProvider {
    static var previews: some View {
        RecordPage()
    }
}
