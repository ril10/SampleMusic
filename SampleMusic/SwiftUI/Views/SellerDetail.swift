//
//  SellerDetail.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 1/28/22.
//

import SwiftUI

struct SellerDetail: View {
    @SwiftUI.State private var sampleType: Int = 0
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                Color(Style.backgroundColor.rawValue)
                    .ignoresSafeArea()
                VStack {
                    VStack(alignment: .center) {
                        Image(systemName: Icons.photo.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(Style.coralColor.rawValue), lineWidth: 5))
                            .shadow(radius: 10)
                    }
                    VStack(alignment: .leading) {
                        List {
                            Text("Firs Name: Some name")
                            Text("Last Name: Some name")
                            Text("Description: Some name")
                            Text("Email: Some name")
                            Text("Gender: Some name")
                        }.frame(width: .infinity, height: 300, alignment: .leading)
                    }
                    HStack(spacing: 100) {
                        Button(
                            action: {},
                            label: {
                                Image(systemName: Icons.sort.rawValue)
                                    .foregroundColor(Color(Style.coralColor.rawValue))
                            }
                        )
                        Button(
                            action: {},
                            label: {
                                Image(systemName: Icons.add.rawValue)
                                    .foregroundColor(Color(Style.coralColor.rawValue))
                            }
                        )
                        Button(
                            action: {},
                            label: {
                                Image(systemName: Icons.mic.rawValue)
                                    .foregroundColor(Color(Style.coralColor.rawValue))
                            }
                        )
                    }.frame(maxWidth: .infinity)
                    HStack {
                        Picker("Select paid or free", selection: $sampleType) {
                            Text("Free").tag(0)
                            Text("Paid").tag(1)
                        }.pickerStyle(.segmented)
                            .background(Color(Style.coralColor.rawValue))
                    }
                    VStack(alignment: .leading) {
                        Text("My Samples List")
                            .padding(.leading)
                        ListOfSamples()
                    }
                }
            }
        }
    }
}

struct SellerDetail_Previews: PreviewProvider {
    static var previews: some View {
        SellerDetail()
    }
}
