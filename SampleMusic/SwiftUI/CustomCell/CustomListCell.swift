//
//  CustomListCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 1/28/22.
//

import SwiftUI

struct CustomListCell: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color(Style.backgroundColor.rawValue)
                .ignoresSafeArea()
            HStack {
                VStack(alignment: .leading) {
                    Text("Some")
                    Text("🍪")
                    HStack {
                        
                    }
                }
                Spacer()
                VStack {
                    Image(systemName: Icons.photo.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(Style.coralColor.rawValue), lineWidth: 5))
                        .shadow(radius: 10)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading).padding(.trailing)
        }
    }
}

struct CustomListCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomListCell()
    }
}
