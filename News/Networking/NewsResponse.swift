//
//  Response.swift
//  News
//
//  Created by Zhanna Sargsyan on 02/07/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

enum NewsApiResponseKey: String {
    case articles
    case sources
}


struct NewsResponse {
    var news: [NewsData]
    var totalCount: Int
    
    init(news: [NewsData] = [], totalCount: Int = 0) {
        self.news = news
        self.totalCount = totalCount
    }
    
    mutating func update(with dict: [String: Any], newsResponseKey: NewsApiResponseKey, page: Int) {
        self.totalCount = newsResponseKey == .articles ? dict["totalResults"] as? Int ?? 0 : 0
        if page == 1 {
            self.news.removeAll()
        }
        guard let articlesResponse = dict[newsResponseKey.rawValue] as? [[String: Any]] else {
            return
        }
        for article in articlesResponse {
            self.news.append(NewsData(with: article))
        }
    }
}
