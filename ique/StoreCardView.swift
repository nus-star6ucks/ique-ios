//
//  StoreCardView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI

struct StoreCardView: View {
    var imageUrl: String
    var category: String
    var heading: String
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                 image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .mask {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                    }
                    .frame(height: 225, alignment: .bottom)
                    .clipped()
             } placeholder: {
                 ProgressView().frame(height: 225, alignment: .center)
             }
                
            Text(heading)
                .font(.footnote.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipped()
                .padding(.top, 16)
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(category)
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 1)
                    .background {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .foregroundColor(.red)
                    }
                Spacer()
                Image(systemName: "ellipsis")
                    .font(.callout)
            }
            .padding(.top, 3)
            .font(.caption2.weight(.semibold))
        }
        .frame(width: 160)
        .clipped()
        .shadow(color: Color(.sRGB, red: 0/255, green: 0/255, blue: 0/255).opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct StoreCardView_Previews: PreviewProvider {
    static var previews: some View {
        StoreCardView(imageUrl: "https://images.unsplash.com/photo-1667114790847-7653bc249e82?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners")
    }
}
