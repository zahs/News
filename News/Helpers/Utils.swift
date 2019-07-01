//
//  Utils.swift
//  News
//
//  Created by Zhanna Sargsyan on 29/06/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

func onMain(_ closure: @escaping (() -> ())) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async(execute: {
            closure()
        })
    }
}

func loadImageFromURL(url: URL, completion: @escaping (Data?) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            print(error!)
            return
        }
        completion(data)
        }.resume()
}

enum CountryCode: String {
    case ae
    case ar
    case at
    case au
    case be
    case bg
    case br
    case ca
    case ch
    case cn
    case co
    case cu
    case cz
    case de
    case eg
    case fr
    case gb
    case gr
    case hk
    case hu
    case id
    case ie
    case il
    case ind = "in"
    case it
    case jp
    case kr
    case lt
    case lv
    case ma
    case mx
    case my
    case ng
    case nl
    case no
    case nz
    case ph
    case pl
    case pt
    case ro
    case rs
    case ru
    case sa
    case se
    case sg
    case si
    case sk
    case th
    case tr
    case tw
    case ua
    case us
    case ve
    case za
}

enum Category : String {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}
