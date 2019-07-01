//
//  NetworkManager.swift
//  News
//
//  Created by Zhanna Sargsyan on 27/06/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

class NetworkManager {
    var newsResponse: NewsResponse = NewsResponse()
    
    func getAllNews(page : Int, pageSize: Int, params: [String: Any], completion: @escaping (_ news: NewsResponse?,_ error: String?)->()) {
        getNews(.everything(params: params), page: page, pageSize: pageSize, articlesResponseKey: NewsApiResponseKey.articles) { (news, error) in
            completion(news, error)
        }
    }
    
    func getTopNews(page : Int, pageSize: Int, params: [String: Any], completion: @escaping (_ news: NewsResponse?,_ error: String?)->()) {
        getNews(.topHeadlines(params: params), page: page, pageSize: pageSize, articlesResponseKey: NewsApiResponseKey.articles) { (news, error) in
            completion(news, error)
        }
    }
    
    func getSources(page : Int, pageSize: Int, params: [String: Any], completion: @escaping (_ news: NewsResponse?,_ error: String?)->()) {
        getNews(.sources(params: params), page: page, pageSize: pageSize, articlesResponseKey: NewsApiResponseKey.sources) { (news, error) in
            completion(news, error)
        }
    }
    
    private func getNews(_ type: NewsApi, page: Int, pageSize: Int, articlesResponseKey: NewsApiResponseKey, completion: @escaping (_ news: NewsResponse?,_ error: String?)->()) {
        let networkFactory = NetworkDispatcherFactory(environment: Environment(name: "news", host: "https://newsapi.org"))
        let dispatcher = networkFactory.makeNetworkProvider()
        do {
            try NewsLoader().send(request: type, dispatcher: dispatcher) { (data) in
                guard let responseData = data else {
                    return
                }
                switch responseData {
                case .error( _ , let error):
                    completion(nil, error?.localizedDescription)
                case .data(let d ):
                    guard let newsDict = d.dict() else {
                        completion(nil, NetworkError.noData.rawValue)
                        return
                    }
                    self.newsResponse.update(with: newsDict, newsResponseKey: articlesResponseKey, page: page)
                    completion(self.newsResponse, nil)
                }
            }
        } catch  {
            completion(nil, error.localizedDescription)
        }
    }
}
