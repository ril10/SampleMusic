//
//  SearchBar.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3/22/22.
//

import SwiftUI

struct SearchBar: View {
    @SwiftUI.State private var searchText: String = ""
    @SwiftUI.State private var isEditing: Bool = false
    var body: some View {
        HStack {
            TextField("Search by name", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 12)
                .onTapGesture {
                    self.isEditing = true
                }
            if isEditing {
                Button(
                    action: {
                        self.isEditing = false
                        self.searchText = ""
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
