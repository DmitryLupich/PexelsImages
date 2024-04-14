//
//  ImageModel.swift
//  PexelsImages
//
//  Created by Dmitriy Lupych on 14.04.2024.
//

import Foundation

struct ImageModel: Decodable {
    let page: Int
    let photos: [Photo]
}

extension ImageModel {
    struct Photo: Decodable, Identifiable {
        let id: Int
        let authorName: String
        let imageSizes: ImageSizes

        enum CodingKeys: String, CodingKey {
            case id
            case imageSizes = "src"
            case authorName = "photographer"
        }
    }
}

extension ImageModel.Photo {
    struct ImageSizes: Decodable {
        let original: String
        let medium: String
    }
}
