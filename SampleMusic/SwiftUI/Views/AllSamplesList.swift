//
//  AllSamplesList.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 2/25/22.
//

import SwiftUI

struct AllSamplesList: View {
    @SwiftUI.State private var sampleType: Int = 0
    @SwiftUI.State private var searchText: String = ""
    var body: some View {
        VStack {
            TextField(
                "Search by name",
                text: $searchText
            )
                .disableAutocorrection(true)
                .padding()
                .textFieldStyle(.roundedBorder)
            HStack {
                Picker("Select paid or free", selection: $sampleType) {
                    Text("By Name").tag(0)
                    Text("By Length").tag(1)
                    Text("By Price").tag(2)
                }.pickerStyle(.segmented)
                    .background(Color(Style.coralColor.rawValue))
            }
            List {
                ListOfSamples()
            }.frame(width: .infinity, height: .infinity)
        }
    }
}

struct AllSamplesList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AllSamplesList()
        }
    }
}
