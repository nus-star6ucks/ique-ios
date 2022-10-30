//
//  AccountLoginView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI

struct AccountLoginView: View {
    @State var username: String = ""
    @State var password: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("")) {
                    TextField("Username", text: $username)
                    TextField("Password", text: $password)
                }
                Section {
                    Button(action: {
                        print("Perform an action here...")
                    }) {
                        Text("Login Now")
                    }
                    Button(action: {
                        print("Perform an action here...")
                    }) {
                        Text("Use third-party accounts to login")
                    }
                }
            }
            .navigationBarTitle("Account Login")
        }
    }
}

struct AccountLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AccountLoginView()
    }
}
