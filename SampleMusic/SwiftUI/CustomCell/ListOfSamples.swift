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
                    CustomImageView(imageWidth: 80.0, imageHeight: 80.0)
                }
            }
    }
}

struct ListOfSamples_Previews: PreviewProvider {
    static var previews: some View {
        ListOfSamples()
    }
}

