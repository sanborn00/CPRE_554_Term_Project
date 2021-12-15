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


@available(iOS 15.0, *)
func refresh(publisher: PassthroughSubject<PageDataModel, Never>, url: String, pageID: String, itemID: String){
    
        guard let url = URL(string: url) else {
            print("Error: cannot create URL")
            return
        }
        
        struct UploadData: Codable {
            let pageID: String
            let id: String
        }
        
        // Add data to the model
        let uploadDataModel = UploadData(pageID: pageID, id: itemID)
        
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
                let pageData: PageDataModel = try! JSONDecoder().decode(PageDataModel.self, from: prettyJsonData)
                
                publisher.send(pageData)
                
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
