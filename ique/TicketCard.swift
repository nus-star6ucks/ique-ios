//
//  TicketCard.swift
//  ique
//
//  Created by PCDotFan on 2022/10/31.
//

import SwiftUI

struct TicketCard: View {
    var imageUrl: String
    var title: String
    var description: String
    
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: imageUrl)) { image in
                     image
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: .infinity)
                        .clipped()
                        .frame(width: 109)
                        .clipped()
                        .mask {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                        }
                 } placeholder: {
                     ProgressView().frame(height: 40, alignment: .center)
                 }
                
                    
                VStack(spacing: 2) {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .clipped()
                        .font(.callout.weight(.semibold))
                    Text(description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .clipped()
                        .font(.footnote.weight(.regular))
                        .foregroundColor(.secondary)
                    Text("Adds 9m")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .clipped()
                        .font(.caption.weight(.medium))
                        .foregroundColor(.blue)
                }
            }
//            Spacer()
//            HStack {
//                Text("Open til 9PM")
//                    .foregroundColor(Color(.sRGB, red: 51/255, green: 193/255, blue: 89/255))
//                    .font(.footnote.weight(.semibold))
//                    .padding(5)
//                    .padding(.horizontal, 2)
//                    .background {
//                        RoundedRectangle(cornerRadius: 14, style: .continuous)
//                        .foregroundColor(.green.opacity(0.31))
//                        .opacity(0.15)
//                    }
//                Text("Drive-thru")
//                    .foregroundColor(Color(.sRGB, red: 255/255, green: 105/255, blue: 0/255))
//                    .font(.footnote.weight(.semibold))
//                    .padding(5)
//                    .padding(.horizontal, 2)
//                    .background {
//                        RoundedRectangle(cornerRadius: 14, style: .continuous)
//                        .foregroundColor(.orange.opacity(0.31))
//                        .opacity(0.15)
//                    }
//                Text("Restrooms")
//                    .foregroundColor(Color(.sRGB, red: 0/255, green: 97/255, blue: 254/255))
//                    .font(.footnote.weight(.semibold))
//                    .padding(5)
//                    .padding(.horizontal, 2)
//                    .background {
//                        RoundedRectangle(cornerRadius: 14, style: .continuous)
//                        .foregroundColor(.blue.opacity(0.31))
//                        .opacity(0.15)
//                    }
//                Spacer()
//            }
        }
        .padding(16)
        .frame(height: 30)
    }
}

struct TicketCard_Previews: PreviewProvider {
    static var previews: some View {
        TicketCard(imageUrl: "https://ique.vercel.app/demo/photo.39.jpeg", title: "In-N-Out Burger", description: "Kettleman City Rest Stop")
    }
}
