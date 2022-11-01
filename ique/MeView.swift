//
//  MeView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import Alamofire

struct MeView: View {
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
//                    Image(systemName: "heart")
                    Text("Rate Us")
                }
                HStack {
//                    Image(systemName: "xmark")
                    Text("Delete Account")
                }
                HStack {
//                    Image(systemName: "xmark")
                    Text("Logout").onAppear {
                        print("donow")

        //                Task {
        //                    print("donow")
        //                    AF
        //                        .request("https://ique.vercel.app/api/users/login", method: .post, parameters: [
        //                            "username": "wwy701",
        //                            "password": "991007"
        //                        ], encoder: JSONParameterEncoder.default).response {
        //                            response in
        //                            debugPrint(response)
        //                        }
        //                }
                    
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
