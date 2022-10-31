//
//  StoreDetailView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import AlertKit


struct StoreDetailView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @StateObject var customAlertManager = CustomAlertManager()
    
    var body: some View {
        VStack {
            Button(action: {
                customAlertManager.show()
            }, label: {
                Text("Show custom alert")
            })
        }
        .customAlert(manager: customAlertManager, content: {
            VStack {
                Text("Hello Custom Alert").bold().padding(.bottom)
                TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }, buttons: [
            .cancel(content: {
                Text("Cancel").bold()
            }),
            .regular(content: {
                Text("Login").bold()
            }, action: {
//                print("Sending email: \(customAlertText)")
            })
        ])
    }
}

struct StoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailView()
    }
}
