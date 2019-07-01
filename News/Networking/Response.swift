//
//  Response.swift
//  News
//
//  Created by Zhanna Sargsyan on 02/07/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case badInput = "There is an issue with input parameters"
    case noData = "No data is available"
    case missingUrl = "Url is missing"
}

public enum Response {
    case data(_: Data)
    case error(_: Int?, _: Error?)
    
    init(_ response: (r: HTTPURLResponse?, d: Data?, e: Error?) ) {
        guard response.r?.statusCode == 200, response.e == nil else {
            self = .error(response.r?.statusCode, response.e)
            return
        }
        
        guard let data = response.d else {
            self = .error(response.r?.statusCode, NetworkError.noData)
            return
        }
        
        self = .data(data)
    }
}

