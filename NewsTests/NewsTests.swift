//
//  NewsTests.swift
//  NewsTests
//
//  Created by Zhanna Sargsyan on 02/07/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import XCTest
@testable import News

class NewsTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLEncoding() {
        guard let url = URL(string: "https:www.google.com/") else {
            XCTAssertTrue(false, "Could not instantiate url")
            return
        }
        var urlRequest = URLRequest(url: url)
        let params: [String: Any] = ["appKey" : "key",
                                     "q" : "testQuery",
                                     "page" : 1]
        
        do {
            let encoder = UrlParameterEncoder()
            try encoder.encode(urlRequest: &urlRequest, with: params)
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }
            
            let expectedURL = "https:www.google.com/?appKey=key&q=testQuery&page=1"
            XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
        }catch {
            
        }
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
