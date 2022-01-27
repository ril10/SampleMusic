//
//  MainScreen.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 1/27/22.
//

import SwiftUI

struct MainScreen: View {
    @SwiftUI.State private var someText: String = ""
    @SwiftUI.State private var somePassword: String = ""
    @SwiftUI.State private var isSecure: Bool = true
    var body: some View {
        ZStack {
            Color(Style.backgroundColor.rawValue)
                .ignoresSafeArea()
            VStack {
                    HStack {
                        Image(Icons.logoApp.rawValue)
                            .resizable(resizingMode: .stretch)
                            .frame(width: 250, height: 250, alignment: .center)
                    }
                VStack(alignment: .center, spacing: 60) {
                    VStack(alignment: .leading, spacing: 10.0) {
                        Text("Sign In")
                            .font(.largeTitle)
                            .bold()
                        Text("Welcome :)")
                        Text("Email")
                            .foregroundColor(Color(Style.coralColor.rawValue))
                        TextField("Enter your login", text: $someText)
                            .textFieldStyle(LabelTextFieldStyle())
                        Text("Password")
                            .foregroundColor(Color(Style.coralColor.rawValue))
                        ZStack(alignment: .trailing) {
                            if isSecure {
                                SecureField("Enter your password", text: $somePassword)
                                    .textFieldStyle(LabelTextFieldStyle())
                            } else {
                                TextField("Enter your password", text: $somePassword)
                                    .textFieldStyle(LabelTextFieldStyle())
                            }
                            Button(action: {
                                isSecure.toggle()
                            }) {
                                Image(systemName: self.isSecure ? Icons.eye.rawValue : Icons.crossEye.rawValue)
                                    .foregroundColor(Color.gray)
                            }
                        }

                    }.padding()
                    VStack(alignment: .center, spacing: 60.0) {
                        HStack() {
                            Button("Sign In") {
                                print("")
                            }
                            .buttonStyle(CoralButton())
                        }.padding(.leading, 20)
                            .padding(.trailing, 20)
                        HStack(alignment: .center) {
                            Button("Forget password?"){}
                            .foregroundColor(Color.gray)
                            .font(.custom(Style.fontTitleLight.rawValue, size: 17))
                            Spacer()
                            Button("Sign Up"){}
                            .foregroundColor(Color(Style.coralColor.rawValue))
                        }.padding(.leading, 20).padding(.trailing, 20)
                    }.frame(width: .infinity, height: 100, alignment: .center)
                }.padding()
            }
        }
    }
}



struct Previews_MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .previewDevice("iPhone 12")
    }
}
