//
//  ContentView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import Alamofire

struct HomeView: View {
    
    @State var storeRows: [[StoreItem]] = []
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.06).edgesIgnoringSafeArea(.all)
                
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("ONLINE QUEUEING SYSTEM")
                            .font(.caption)
                        Text("iQueue")
                            .font(.title)
                            .bold()
                    }
                    Spacer()
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
                                Text("My Magazines")
                            }
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(.primary)
                            }
                            .font(.footnote.weight(.medium))
                            .foregroundColor(Color(.systemBackground))
                            HStack {
                                Image(systemName: "arrow.down.circle.fill")
                                Text("Downloaded")
                            }
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color(.systemFill))
                            }
                            .font(.footnote.weight(.medium))
                            HStack {
                                Image(systemName: "newspaper.fill")
                                Text("Newspapers")
                            }
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(Color(.systemFill))
                            }
                            .font(.footnote.weight(.medium))
                            HStack {
                                Image(systemName: "rectangle.grid.3x2.fill")
                                Text("Catalog")
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
                                Spacer()
                                if (row.count > 1) {
                                    StoreCardView(imageUrl: row[1].resources.imageUrl, category: row[1].type, heading: row[1].name)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .onAppear {
                        Task {
                            let storeItems = try await getStores()
                            self.storeRows = storeItems.chunked(into: 2)
                        }
                    }
                }
                    .navigationBarTitle(Text("iQue"), displayMode: .inline)
                Spacer()
                    .frame(height: 108)
                    .clipped()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
