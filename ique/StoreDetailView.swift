//
//  StoreDetailView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI
import AlertKit
import Alamofire

struct StoreDetailView: View {
    
    @State var store: StoreDetail = StoreDetail(id: 0, address: "", merchantId: 0, name: "Luca Italian Cuisine", type: "Loading", status: "Loading", registerTime: 0, resources: StoreResources(description: "The beautiful range of Apple Naturalé that has an exciting mix of natural ingredients. With the Goodness of 100% Natural Ingredients", imageUrl: "https://ique.vercel.app/demo/photo.1.jpeg", ratings: 5), phoneNumbers: [], seatTypes: [], queuesInfo: [])
    
    var body: some View {
        VStack {
            VStack {
                Rectangle()
                    .frame(width: 32, height: 32)
                    .clipped()
                    .foregroundColor(Color(.systemBackground))
                    .overlay {
                        Image(systemName: "arrow.backward")
                        .foregroundColor(.primary)
                        .font(.title3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipped()
                    .padding()
            }
            .padding(.top, 12)
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
                Text(store.address)
                    .font(.system(size: 15, weight: .light))
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Image(systemName: "quote.opening")
                        .imageScale(.medium)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .clipped()
                        .font(.title3)
                        .padding(.bottom)
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
            .padding(.horizontal, 24)
            
            Spacer()
        }.onAppear {
            Task {
                let store = try await getStoreDetail(storeId: 240)
                self.store = store
            }
        }
        Spacer()
            .frame(height: 108)
            .clipped()
    }
}

struct StoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailView()
    }
}

