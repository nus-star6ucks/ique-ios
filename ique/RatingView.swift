//
//  RatingView.swift
//  ique
//
//  Created by PCDotFan on 2022/10/30.
//

import SwiftUI

struct RatingView: View {
    var maxRating = 5
    var rating = 2
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }

    var body: some View {
        HStack{
            ForEach(1..<maxRating + 1, id:\.self){number in
                image(for: number)
                    .font(.system(size: 45))
                    .foregroundColor(number>rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                        }
                    }
            }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
