//
//  Loader.swift
//  News
//
//  Created by Zhanna Sargsyan on 02/07/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

protocol Loader {
    associatedtype Output
    
    func send(request: Request, dispatcher: Dispatcher, completion: @escaping (Output) -> ()) throws
    
}

class NewsLoader : Loader {
    
    func send(request: Request, dispatcher: Dispatcher, completion: @escaping (Response?) -> ()) throws {
        try dispatcher.execute(request: request) { (response) in
            completion(response)
        }
    }
}
