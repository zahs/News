//
//  Request.swift
//  News
//
//  Created by Zhanna Sargsyan on 02/07/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

public protocol Request {
    var key: String {get}
    var path : String {get}
    var method: HTTPMethod {get}
    var parameters: RequestParams {get}
    var headers: [String: Any]? {get}
}
