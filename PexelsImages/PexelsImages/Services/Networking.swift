//
//  Networking.swift
//  PexelsImages
//
//  Created by Dmitriy Lupych on 14.04.2024.
//

import Foundation

protocol NetworkingProtocol {
    func getImageModels(for endpoint: Endpoint) async throws -> ImageModel
}

final class Networking {
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder


    init(
        urlSession: URLSession = .shared,
        jsonDecoder: JSONDecoder = .init()
    ) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
}

//MARK: - Get Imags Models

extension Networking: NetworkingProtocol {
    func getImageModels(for endpoint: Endpoint) async throws -> ImageModel {
        try await request(endpoint: endpoint)
    }
}

//MARK: - Generic request

private extension Networking {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard
            let request = endpoint.request
        else {
            throw NetworkingError.generic
        }

        do {
            let response = try await urlSession.data(for: request)
            let model = try jsonDecoder.decode(T.self, from: response.0)
            return model
        } catch {
            //TODO: - Handle Errors
            print("❇️ Error:", error)
            throw error
        }
    }
}

//MARK: - Error

enum NetworkingError: Error {
    case generic
}
