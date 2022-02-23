//
//  ListOfSamples.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 2/23/22.
//

import SwiftUI

struct ListOfSamples: View {
    @SwiftUI.State private var duration = 0.0
    @SwiftUI.State private var isEditing = false
    var body: some View {
        List {
            HStack {
                VStack(alignment: .leading) {
                    Text("Some")
                    Text("0🍪")
                    HStack {
                        Button(
                            action: {},
                            label: {
                                Image(systemName: Icons.play.rawValue)
                                    .foregroundColor(Color(Style.coralColor.rawValue))
                            }
                        )
                        Slider(
                            value: $duration,
                            in: 0...100,
                            step: 0.1
                        ) {
                        
                        } minimumValueLabel: {
                            Text("00:00")
                        } maximumValueLabel: {
                            Text("00:30")
                        } onEditingChanged: { editing in
                            isEditing = editing
                        }

                    }
                }
                VStack(alignment: .trailing) {
                    Image(systemName: Icons.photo.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(Style.coralColor.rawValue), lineWidth: 5))
                }
            }
        }//.frame(width: .infinity, alignment: .center)
    }
}

struct ListOfSamples_Previews: PreviewProvider {
    static var previews: some View {
        ListOfSamples()
    }
}
