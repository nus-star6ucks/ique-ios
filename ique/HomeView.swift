//
//  ContentView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import Alamofire
import SwiftUIRouter
import AlertKit

struct HomeView: View {
    
    @State var storeRows: [[StoreItem]] = []
    @State var isLoggedIn = false
    
    @EnvironmentObject private var navigator: Navigator
    @StateObject var alertManager = AlertManager()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.06).edgesIgnoringSafeArea(.all)
                
            ScrollView(showsIndicators: false) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text("ONLINE QUEUEING SYSTEM")
                            .font(.caption)
                        Text("iQueue")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    if (isLoggedIn) {
                        Image("default-avatar")
                            .resizable()
                            .frame(width: 42.0, height: 42.0)
                            .clipShape(Circle())
                            .onTapGesture {
                                alertManager.show(primarySecondary: .info(
                                        title: "Logout Confirmation",
                                        message: "Are you sure want to logout?",
                                        primaryButton: Alert.Button.destructive(Text("OK")) {
                                            Task {
                                                do {
                                                    try keychain.deleteItem(forKey: "token")
                                                    try keychain.deleteItem(forKey: "user")
                                                    self.isLoggedIn = false
                                                } catch {
                                                }
                                            }
                                        },
                                        secondaryButton: Alert.Button.cancel()))
                            }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                VStack {
                    Spacer()
                        .frame(height: 36)
                        .clipped()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            HStack {
                                Image(systemName: "rectangle.stack.fill")
                                Text("Latest")
                            }
                                .padding(12)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(.primary)
                                }
                                .font(.footnote.weight(.medium))
                                .foregroundColor(Color(.systemBackground))
                            HStack {
                                Image(systemName: "heart.fill")
                                Text("Favorites")
                            }
                                .padding(12)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(Color(.systemFill))
                                }
                                .font(.footnote.weight(.medium))
                            HStack {
                                Image(systemName: "star.fill")
                                Text("Top Rated")
                            }
                                .padding(12)
                                .background {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(Color(.systemFill))
                                }
                                .font(.footnote.weight(.medium))
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                    HStack {
                        Text("All Stores")
                        Spacer()
                    }
                    .padding(.horizontal)
                    .font(.title3.weight(.bold))
                    
                    VStack(spacing: 24) {
                        ForEach(Array(storeRows.enumerated()), id: \.offset) { index, row in
                            HStack {
                                StoreCardView(imageUrl: row[0].resources.imageUrl, category: row[0].type, heading: row[0].name)
                                    .onTapGesture {
                                        navigator.navigate("/stores/" + String(row[0].id))
                                    }
                                Spacer()
                                if (row.count > 1) {
                                    StoreCardView(imageUrl: row[1].resources.imageUrl, category: row[1].type, heading: row[1].name)
                                        .onTapGesture {
                                            navigator.navigate("/stores/" + String(row[1].id))
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .onAppear {
                        Task {
                            let storeItems = try await getStores()
                            
                            self.storeRows = storeItems.chunked(into: 2)
                            do {
                                try getUserFromKeyChain()
                                self.isLoggedIn = true
                            } catch {
                                self.isLoggedIn = false
                            }
                        }
                    }
                    .uses(alertManager)
                }
                Spacer()
                    .frame(height: 108)
                    .clipped()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
