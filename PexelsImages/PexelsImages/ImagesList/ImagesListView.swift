//
//  ImagesListView.swift
//  PexelsImages
//
//  Created by Dmitriy Lupych on 14.04.2024.
//

import SwiftUI

enum NavPath {
    case details
}

struct ImagesListView: View {
    @ObservedObject var viewModel: ImagesListViewModel
    @State private var path = [NavPath]()

    var body: some View {
        NavigationStack(path: $path) {
            List(Array(viewModel.photos.enumerated()), id: \.element.id) { (offSet, photo) in
                ImageListRow(photo: photo, isFullSize: false)
                    .frame(height: 200)
                    .onAppear {
                        if offSet == viewModel.photos.count - 3 {
                            loadNextImages()
                        }
                    }
                    .onTapGesture {
                        viewModel.selectedPhoto = photo
                        path = [.details]
                    }
            }
            .refreshable {
                Task { await viewModel.refresh() }
            }
            .navigationDestination(for: NavPath.self) { path in
                switch path {
                case .details:
                    ImageListRow(photo: viewModel.selectedPhoto!, isFullSize: true)
                }
            }
        }
        .onAppear { loadNextImages() }
    }
}

private extension ImagesListView {
    func loadNextImages() {
        Task {
            await viewModel.loadNextImages()
        }
    }
}
