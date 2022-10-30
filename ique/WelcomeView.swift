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
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Image(systemName: "applelogo")
                        .imageScale(.medium)
                    Text("Continue with Apple")
                }
                    .font(.body.weight(.medium))
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .foregroundColor(Color(.systemBackground))
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.primary)
                    }
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "envelope.fill")
                        .imageScale(.medium)
                    Text("Continue with Account")
                }
                    .font(.body.weight(.medium))
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .foregroundColor(Color(.displayP3, red: 244/255, green: 188/255, blue: 73/255))
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(.clear.opacity(0.25), lineWidth: 0)
                        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.yellow.opacity(0.1)))
                    }
                
            }
            Text("By signing in you accept our Terms of use and Privacy Policy.")
                .foregroundColor(Color(.tertiaryLabel))
                .font(.subheadline)
                .multilineTextAlignment(.center).padding(.top)
        }.padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
