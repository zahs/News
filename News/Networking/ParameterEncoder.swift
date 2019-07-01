//
//  ParameterEncoder.swift
//  News
//
//  Created by Zhanna Sargsyan on 02/07/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

public enum RequestParams {
    case body (_ : [String: Any]?)
    case url (_ : [String: Any]?)
}

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: [String: Any]) throws
}

public struct UrlParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: [String: Any]) throws {
        guard let urlString = urlRequest.url?.absoluteString else {
            throw NetworkError.missingUrl
        }
        if let params = parameters as? [String : String] {
            let queryParams = params.map { pair  in
                return URLQueryItem(name: pair.key, value: pair.value)
            }
            guard var components = URLComponents(string: urlString) else {
                throw NetworkError.badInput
            }
            components.queryItems = queryParams
            urlRequest.url = components.url
        } else {
            throw NetworkError.badInput
        }
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}

public struct BodyParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: [String : Any]) throws {
        if let params = parameters as? [String : String] {
            let body = try? JSONEncoder().encode(params)
            urlRequest.httpBody = body
        } else {
            throw NetworkError.badInput
        }
    }
}
