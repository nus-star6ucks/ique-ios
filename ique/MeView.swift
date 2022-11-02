//
//  MeView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import Alamofire
import KeychainSwift
import SwiftUIRouter

struct MeView: View {
    
    @EnvironmentObject private var navigator: Navigator
    
    var body: some View {
        VStack {
             VStack(alignment: .leading) {
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
                    Text("Rate Us")
                }
                HStack {
                    Text("Logout").onTapGesture {
                        let keychain = KeychainSwift()
                        keychain.delete("user")
                        keychain.delete("token")
                        
                        navigator.navigate("auth", replace: true)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Profile")
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
