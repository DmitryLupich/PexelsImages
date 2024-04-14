//
//  ContentView.swift
//  PexelsImages
//
//  Created by Dmitriy Lupych on 14.04.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ImagesListView(viewModel: ImagesListViewModel(networking: Networking()))
    }
}

#Preview {
    ContentView()
}
