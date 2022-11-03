//
//  MeView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import Alamofire
import SwiftUIRouter


struct MeView: View {
    
    @EnvironmentObject private var navigator: Navigator
    @State var user: UserResponse = UserResponse(id: 0, username: "Test", userType: "customer", phoneNumber: "00000000", createTime: Date.now)
    
    var body: some View {
        VStack {
             VStack(alignment: .leading) {
                 HStack {
                     VStack(alignment: .leading) {
                         Text(":-) Welcome Back,")
                             .font(.title3)
                             .padding(.bottom, 0.5)
                         Text(user.username)
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
                        do {
                            try keychain.deleteItem(forKey: "token")
                            try keychain.deleteItem(forKey: "user")
                            navigator.navigate("/auth", replace: true)
                        } catch {
                            
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Profile")
        }.onAppear {
            Task {
                do {
                    let user = try getUserFromKeyChain()
                    self.user = user
                } catch {
                    try keychain.deleteItem(forKey: "token")
                    try keychain.deleteItem(forKey: "user")
                    navigator.navigate("/auth", replace: true)
                }
            }
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
