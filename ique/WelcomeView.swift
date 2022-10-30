//
//  WelcomeView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack() {
            VStack() {
                 Image("login").resizable()
                     .aspectRatio(contentMode: .fit)
                 VStack() {
                     Text("Queue Better,").font(.title).bold()
                     Text("Enjoy Life Happier.").font(.title).bold()
                 }
                 .padding(.top)
            }
            Spacer()
            VStack {
                Button(action: {
                    print("ntf")
                }) {
                    Text("Sign in with GitHub")
                        .frame(maxWidth: .infinity)
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 0.06274509803921569, green: 0.7254901960784313, blue: 0.5058823529411764))
                        .cornerRadius(30)
                }.padding(.bottom, 2.0)
                Button(action: {
                    print("ntf")
                }) {
                    Text("Sign in with Account")
                        .frame(maxWidth: .infinity)
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(red: 0.001, green: 0.0, blue: 0.0))
                        .cornerRadius(30)
                }
            }
            Text("By signing in you accept our Terms of use and Privacy Policy.")
                .font(.footnote)
                .multilineTextAlignment(.center).padding(.top)
        }.padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
