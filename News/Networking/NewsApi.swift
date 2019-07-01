//
//  NewsApi.swift
//  News
//
//  Created by Zhanna Sargsyan on 02/07/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

public enum NewsApi {
    case topHeadlines(params: [String: Any])
    case everything(params: [String: Any])
    case sources(params: [String: Any])
    
    func description() -> String {
        switch self {
        case .topHeadlines(_):
            return "Top headlines"
        case .everything(_):
            return "All"
        case .sources(_):
            return "Sources"
        }
    }
    
}

extension NewsApi: Request {
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var parameters: RequestParams {
        let keyParam: [String: Any] = ["apiKey": self.key]
        switch self {
        case .topHeadlines(let params):
            return .url(keyParam.merging(params ) { $1 })
        case .everything(let params):
            return .url(keyParam.merging(params ) { $1 })
        case .sources(let params):
            return .url(keyParam.merging(params ) { $1 })
        }
    }
    
    public var headers: [String : Any]? {
        return [:]
    }
    
    public var key: String {
        return "7e064b3413cc4d9bbef04e355c0aaeff"
    }
    
    public var path: String {
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
        case .everything:
            return "/v2/everything"
        case .sources:
            return "v2/sources"
        }
    }
    
}
