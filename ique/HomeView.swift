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
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 39)
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
                .padding(.bottom, 30)
                HStack {
                    Text("All Stores")
                    Spacer()
                    Image(systemName: "ellipsis.circle")
                        .font(.title3.weight(.medium))
                        .foregroundColor(.red)
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
                .padding(.top, 20)
                .onAppear {
                    AF
                        .request("https://ique.vercel.app/api/stores/list")
                        .validate(statusCode: 200..<300)
                        .responseDecodable(of: [StoreItem].self) { response in
                            debugPrint(response)
                            switch response.result {
                                case .success(let storeItems):
                                    self.storeRows = storeItems.chunked(into: 2)
                                case .failure(let error):
                                    print("error", error.localizedDescription)
                            }
                        }
                }
            }
            Spacer()
                .frame(height: 108)
                .clipped()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
