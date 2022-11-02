//
//  StoreDetailView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import AlertKit
import Alamofire
import SwiftUIRouter

struct StoreDetailView: View {
    
    var storeId: String
    
    init(storeId: String) {
        self.storeId = storeId
    }
    
    @EnvironmentObject private var navigator: Navigator
    
    @State var store: StoreDetail = StoreDetail(id: 0, address: "", merchantId: 0, name: "Loading", type: "Loading", status: "Loading", registerTime: Date.now, resources: StoreResources(description: "", imageUrl: "", ratings: 0), phoneNumbers: [], seatTypes: [], queuesInfo: [])
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.06).edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack() {
                    HStack(alignment: .center) {
                        Rectangle()
                            .frame(width: 32, height: 32)
                            .clipped()
                            .foregroundColor(Color(.systemBackground))
                            .overlay {
                                Image(systemName: "arrow.backward")
                                    .font(.system(size: 16))
                                    .foregroundColor(.primary)
                            }
                            .clipped()
                            .cornerRadius(4)
                            .padding()
                            .onTapGesture {
                                navigator.goBack()
                            }
                        Spacer()
                        Text(store.name)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                        Spacer()
                        Rectangle()
                            .frame(width: 32, height: 32)
                            .padding()
                            .opacity(0)
                    }
                    .padding(12)
                }
                    .padding(.top, 24)
                    .frame(maxWidth: .infinity, maxHeight: 300, alignment: .top)
                    .clipped()
                    .background {
                        AsyncImage(url: URL(string: store.resources.imageUrl)) { image in
                             image
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                         } placeholder: {
                             ProgressView().frame(height: 300, alignment: .center)
                         }
                    }
                    .mask {
                        Rectangle()
                    }
                    .cornerRadius(12)
                    .ignoresSafeArea()
                    
                    
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(store.name)
                            .font(.system(size: 29, weight: .semibold))
                        Spacer()
                        HStack(alignment: .firstTextBaseline, spacing: 3) {
                            Image(systemName: "star")
                                .foregroundColor(.orange)
                            Text(String(store.resources.ratings))
                        }
                        .font(.system(size: 16, weight: .regular))
                    }
                    .padding(.top, -24)
                }
                .padding(.horizontal, 24)
                
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Text(store.resources.description)
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineSpacing(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .clipped()
                    }
                    .padding()
                    HStack {
                        VStack(alignment: .leading) {
                            Text(store.address)
                                .font(.subheadline.weight(.semibold))
                            Text(store.type)
                                .foregroundColor(.secondary)
                                .font(.footnote)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .clipped()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .fill(Color(.systemGray5))
                    }
                }
                .clipped()
                .background {
                    Rectangle()
                    .fill(Color(.systemGray6))
                }
                .mask {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Queues")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                Spacer()
            }.onAppear {
                Task {
                    let store = try await getStoreDetail(storeId: storeId)
                    self.store = store
                }
            }
            Spacer()
                .frame(height: 108)
                .clipped()
        }
    }
}

struct StoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailView(storeId: "240")
    }
}

