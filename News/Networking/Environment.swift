//
//  Environment.swift
//  News
//
//  Created by Zhanna Sargsyan on 02/07/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

public struct Environment {
    var name : String
    var host: String
    var headers: [String:Any] = [:]
    
    public init(name: String, host: String, headers: [String: Any] = [:]) {
        self.name = name
        self.host = host
        self.headers = headers
    }
}
