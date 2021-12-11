//
//  NetworkManager.swift
//  Client
//
//  Created by Shuangquan on 10/28/21.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String), parserError(reason: String)

    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason), .parserError(let reason):
            return reason
        }
    }
}

struct Activity: Decodable, CustomStringConvertible {
    var icon_url: String
    var id: String
    var value: String

    var description: String {
        return value
    }
}

@available(iOS 15.0.0, *)
func fetch(url: URL) async throws -> Data {
    let request = URLRequest(url: url)
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw APIError.unknown
        }
        return data
    } catch let error {
        if let error = error as? APIError {
            throw error
        } else {
            throw APIError.apiError(reason: error.localizedDescription)
        }
    }
}

@available(iOS 15.0.0, *)
func fetch<T: Decodable>(url: URL) async throws -> T {
    do {
        let data = try await fetch(url: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch let error {
        if let error = error as? DecodingError {
            var errorToReport = error.localizedDescription
            switch error {
            case .dataCorrupted(let context):
                let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) - (\(details))"
            case .keyNotFound(let key, let context):
                let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
            case .typeMismatch(let type, let context), .valueNotFound(let type, let context):
                let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
            @unknown default:
                break
            }
            throw APIError.parserError(reason: errorToReport)
        }  else {
            throw APIError.apiError(reason: error.localizedDescription)
        }
    }
}


