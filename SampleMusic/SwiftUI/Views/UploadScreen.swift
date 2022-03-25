//
//  UploadScreen.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/22/22.
//

import SwiftUI

struct UploadScreen: View {
    @SwiftUI.State var sampleType = ""
    @SwiftUI.State var sampleName = ""
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                VStack(alignment: .leading) {
                    CustomTextStyle(text: "1.Upload image for sample")
                }
                CustomImageView(imageWidth: 180.0, imageHeight: 180.0)
                Button(
                    action: {},
                    label: {
                        Image(systemName: Icons.plusSquare.rawValue)
                            .resizable()
                            .frame(width: 35, height: 35)
                    })
                    .buttonStyle(GrayButton())
                VStack(alignment: .leading) {
                    CustomTextStyle(text: "2.Type sample music")
                    TextField("Type sample name", text: $sampleName)
                        .overlay(VStack{
                            Divider()
                                .offset(x: 0, y: 15)
                        })
                }.padding()
                VStack(alignment: .leading) {
                    CustomTextStyle(text: "3.Choose sample to upload")
                }
                Button(
                    action: {},
                    label: {
                        Image(systemName: Icons.plusSquare.rawValue)
                            .resizable()
                            .frame(width: 35, height: 35)
                    })
                    .buttonStyle(GrayButton())
                VStack(alignment: .leading) {
                    CustomTextStyle(text: "4.Select distribution of your sample")
                }
                HStack(alignment: .center, spacing: 100) {
                    RadioButton(
                        isActive: $sampleType.wrappedValue == "Paid" ? true : false,
                        label: "Paid",
                        completion: { type in
                            self.sampleType = type
                        }
                    )
                    RadioButton(
                        isActive: $sampleType.wrappedValue == "Free" ? true : false,
                        label: "Free",
                        completion: { type in
                            self.sampleType = type
                        }
                    )
                }.padding(.top, 10)
                Button(
                    action: {},
                    label: {
                        Text("Add")
                    })
                    .buttonStyle(CoralButton())
                    .padding()
                    .padding(.top, 70)
            }
        }
    }
}

struct UploadScreen_Previews: PreviewProvider {
    static var previews: some View {
        UploadScreen()
    }
}
