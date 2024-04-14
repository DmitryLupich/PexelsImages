//
//  EndPoint.swift
//  PexelsImages
//
//  Created by Dmitriy Lupych on 14.04.2024.
//

import Foundation

enum Endpoint {
    case images(page: Int)

    var request: URLRequest? {
        guard var url = baseUrl else { return .none }
        url.append(queryItems: queries)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(AppConstants.apiKey, forHTTPHeaderField: "Authorization")

        return request
    }

    private var baseUrl: URL? {
        URL(string: AppConstants.baseUrl)
    }

    private var queries: [URLQueryItem] {
        switch self {
        case let .images(page: page):
            return [
                URLQueryItem(
                    name: "per_page",
                    value: "10"
                ),
                URLQueryItem(
                    name: "page",
                    value: "\(page)"
                )
            ]
        }
    }
}
