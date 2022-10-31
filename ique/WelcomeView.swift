//
//  WelcomeView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import AlertKit
import WebKit
import Alamofire
import KeychainSwift

struct WebView : UIViewRepresentable {
    @State var url: String // 1
    

    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: URL(string: url)!))
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}


struct WelcomeView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @StateObject var customAlertManager = CustomAlertManager()
    
    @State var showRegisterWebView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack() {
                    VStack() {
                         Image("login").resizable()
                             .aspectRatio(contentMode: .fit)
                         VStack() {
                             Text("Queue Better,").font(.title).multilineTextAlignment(.leading).bold()
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
                            Image(systemName: "phone.fill")
                                .imageScale(.medium)
                            Text("Continue with Account")
                        }
                            .font(.body.weight(.medium))
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(.clear.opacity(0.25), lineWidth: 0)
                                .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.green.opacity(0.1)))
                            }
                            .onTapGesture {
                                customAlertManager.show()
                            }
                        
                    }
                    Button("Join Us Now!") {
                        self.showRegisterWebView = true
                    }
                        .foregroundColor(Color(.systemBlue))
                        .font(.body)
                        .multilineTextAlignment(.center).padding(.top)
                        .fullScreenCover(isPresented: $showRegisterWebView) {
                            WebView(url: "https://ique.vercel.app/#/signup")
                        }
                }.padding()
            }.customAlert(manager: customAlertManager, content: {
                VStack {
                    Text("Contiue with Account").bold().padding(.bottom)
                    TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle())
                        .textCase(.lowercase)
                    SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }, buttons: [
                .cancel(content: {
                    Text("Cancel")
                }),
                .regular(content: {
                    Text("Login").bold()
                }, action: {
                    if (username.isEmpty || password.isEmpty) {
                        return
                    }
                    AF
                        .request("https://ique.vercel.app/api/users/login", method: .post, parameters: [
                            "username": username,
                            "password": password
                        ], encoder: JSONParameterEncoder.default)
                        .validate(statusCode: 200..<300)
                        .responseDecodable(of: LoginResponse.self) { response in
                            switch response.result {
                                case .success(let res):
                                    let keychain = KeychainSwift()
                                    keychain.set("token", forKey: res.token)
                                    
                                case .failure(let err):
                                    debugPrint(err)
                            }
                            debugPrint(response)
                        }
                })
            ])
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
