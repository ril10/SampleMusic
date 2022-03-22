//
//  ImageView.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/22/22.
//

import SwiftUI

struct CustomImageView: View {
    @SwiftUI.State var imageWidth: CGFloat
    @SwiftUI.State var imageHeight: CGFloat
    var body: some View {
        Image(systemName: Icons.photo.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: imageWidth, height: imageHeight, alignment: .center)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color(Style.coralColor.rawValue), lineWidth: 5))
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(
            imageWidth: 150.0,
            imageHeight: 150.0
        )
    }
}
