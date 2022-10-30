//
//  ContentView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI

struct HomeView: View {
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
                    HStack {
                        StoreCardView(imageUrl: "https://images.unsplash.com/photo-1667114790847-7653bc249e82?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners")
                        Spacer()
                        StoreCardView(imageUrl: "https://images.unsplash.com/photo-1667114790847-7653bc249e82?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners")

                    }
                    .padding(.horizontal)
                }
                .padding(.top, 20)
            }
            Spacer()
                .frame(height: 108)
                .clipped()
        }
        .overlay {
            Image("myImage")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .opacity(0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
