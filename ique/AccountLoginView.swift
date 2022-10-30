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
        VStack(alignment: .leading) {
            Text("Account Login")
                .font(.largeTitle)
                .bold()
            TextField("Username", text: $username)
                .padding()
                .background()
                .cornerRadius(5.0)
            TextField("Password", text: $password)
                .padding()
                .background()
                .cornerRadius(5.0)
        }
    }
}

struct AccountLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AccountLoginView()
    }
}
