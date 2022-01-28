//
//  SignUp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 1/28/22.
//

import SwiftUI

struct SignUp: View {
    @SwiftUI.State private var someText: String = ""
    @SwiftUI.State private var somePassword: String = ""
    @SwiftUI.State private var isSecure: Bool = true
    @SwiftUI.State var userType = ""
    var body: some View {
        ZStack(alignment: .top) {
            Color(Style.backgroundColor.rawValue)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 60) {
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
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
                    VStack(alignment: .leading) {
                        Text("Choose your role*")
                        HStack {
                            RadioButton(
                                isActive: $userType.wrappedValue == "User" ? true : false,
                                label: "User",
                                completion: { type in
                                    self.userType = type
                                }
                            )
                            RadioButton(
                                isActive: $userType.wrappedValue == "Seller" ? true : false,
                                label: "Seller",
                                completion: { type in
                                    self.userType = type
                                }
                            )
                        }.padding(.top, 20)
                    }.padding(.top, 50).padding(.bottom, 100)
                    VStack(alignment: .center, spacing: 60.0) {
                        HStack() {
                            Button("Continue") {
                                print("")
                            }
                            .buttonStyle(CoralButton())
                        }.padding(.leading, 20).padding(.trailing, 20)
                        HStack(alignment: .center) {
                            Text("Have an account?")
                            .foregroundColor(Color.gray)
                            .font(.custom(Style.fontTitleLight.rawValue, size: 17))
                            Spacer()
                            Button("Sign In"){}
                            .foregroundColor(Color(Style.coralColor.rawValue))
                        }.padding(.leading, 20).padding(.trailing, 20)
                    }.frame(width: .infinity, height: 100, alignment: .center)
                }.padding()
            }.padding(.top, 50)
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
