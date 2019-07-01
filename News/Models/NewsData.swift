//
//  NewsData.swift
//  News
//
//  Created by Zhanna Sargsyan on 28/06/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

struct NewsData: Decodable {
    let author: String
    let title: String
    let description: String
    let publishedAt: String
    let urlToImage: String
    
    init(with dictionary: [String: Any]) {
        self.author = dictionary["author"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        let dateStr = dictionary["publishedAt"] as? String ?? ""
        self.publishedAt =  dateStr.formatDate()
        self.urlToImage = dictionary["urlToImage"] as? String ?? ""
    }
}
