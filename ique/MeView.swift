//
//  MeView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI

struct MeView: View {
    var body: some View {
        VStack {
             VStack(alignment: .leading) {
                 Text("Me")
                     .font(.largeTitle)
                     .bold()
                 HStack {
                     VStack(alignment: .leading) {
                         Text(":-) Welcome Back,")
                             .font(.title3)
                             .padding(.bottom, 0.5)
                         Text("wwy701")
                             .font(.title)
                     }
                     Spacer()
                     Image("default-avatar")
                                     .resizable()
                                     .frame(width: 72.0, height: 72.0)
                                     .clipShape(Circle())
                     
                 }
             }
             .padding()
            List {
                HStack(alignment: .bottom) {
//                    Image(systemName: "heart")
                    Text("Rate Us")
                }
                HStack {
//                    Image(systemName: "xmark")
                    Text("Delete Account")
                }
                HStack {
//                    Image(systemName: "xmark")
                    Text("Logout")
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
