//
//  Dispatcher.swift
//  News
//
//  Created by Zhanna Sargsyan on 02/07/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

public protocol Dispatcher {
    init (environment: Environment)
    func execute(request: Request, completion: @escaping(Response?) -> ()) throws
    func cancel()
}


public class NetworkDispatcherFactory {
    private var environment: Environment
    required init(environment: Environment) {
        self.environment = environment
    }
    
    func makeNetworkProvider() -> Dispatcher {
        return NetworkDispatcher(environment: environment)
    }
}

extension NetworkDispatcherFactory {
    public class NetworkDispatcher: Dispatcher {
        var task: URLSessionDataTask?
        let environment: Environment
        
        required public init(environment: Environment) {
            self.environment = environment
        }
        
        public func cancel() {
            self.task?.cancel()
        }
        
        public func execute(request: Request, completion: @escaping (Response?) -> ()) throws {
            let request = try prepare(request: request)
            self.task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let r = Response((r: response as? HTTPURLResponse, d: data, e: error))
                completion(r)
            }
            task?.resume()
        }
        
        func prepare(request: Request) throws -> URLRequest {
            let fullUrl = "\(environment.host)/\(request.path)"
            
            var apiRequest = URLRequest(url: URL(string: fullUrl)!)
            apiRequest.httpMethod = request.method.rawValue
            
            switch request.parameters {
            case .body(let params):
                guard let urlParams = params else {
                    return apiRequest
                }
                try BodyParameterEncoder().encode(urlRequest: &apiRequest, with: urlParams)
            case .url(let params):
                guard let urlParams = params else {
                    return apiRequest
                }
                try UrlParameterEncoder().encode(urlRequest: &apiRequest, with: urlParams)
            }
            environment.headers.forEach { apiRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
            request.headers?.forEach { apiRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key) }
            
            return apiRequest
        }
    }
}
