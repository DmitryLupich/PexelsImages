//
//  ImagesListViewModel.swift
//  PexelsImages
//
//  Created by Dmitriy Lupych on 14.04.2024.
//

import Foundation

final class ImagesListViewModel: ObservableObject {
    @Published var photos: [ImageModel.Photo] = []
    var selectedPhoto: ImageModel.Photo?
    private var currentPage: Int = .zero
    
    private let networking: NetworkingProtocol

    init(networking: NetworkingProtocol) {
        self.networking = networking
        URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
        URLCache.shared.diskCapacity = 500_000_000
    }

    @MainActor
    func loadNextImages() async {
        currentPage += 1
        do {
            let nextObject = try await networking.getImageModels(for: .images(page: currentPage))
            let newPhotos = nextObject.photos
            
            photos.append(contentsOf: newPhotos)
        } catch {
            //TODO: - Handle Error
        }
    }

    @MainActor
    func refresh() async {
        photos = []
        currentPage = .zero
        await loadNextImages()
    }
}
