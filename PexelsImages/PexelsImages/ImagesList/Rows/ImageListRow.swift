//
//  ImageListRow.swift
//  PexelsImages
//
//  Created by Dmitriy Lupych on 14.04.2024.
//

import SwiftUI

struct ImageListRow: View {
    let photo: ImageModel.Photo
    let isFullSize: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            photoView
            authorNameView
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 8)
    }
}

private extension ImageListRow {
    var authorNameView: some View {
        Text(photo.authorName)
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
            .background {
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
    }
}

private extension ImageListRow {
    var photoUrl: URL? {
        URL(string: isFullSize ? photo.imageSizes.original : photo.imageSizes.medium)
    }

    var photoView: some View {
        Color.clear.overlay {
            AsyncImage(url: photoUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Text("Photo loading...")
            }
        }
    }
}
