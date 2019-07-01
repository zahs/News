//
//  Extensions.swift
//  News
//
//  Created by Zhanna Sargsyan on 28/06/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation

extension Data {
    public func dict() -> [String: Any]? {
        if let d = try? JSONSerialization.jsonObject(with: self, options: []) {
            return d as? [String : Any]
        }
        return nil
    }
    
    public func array() -> [Any]? {
        if let d = try? JSONSerialization.jsonObject(with: self, options: []) {
            return d as? [Any]
        }
        return nil
    }
}

extension String {
    func formatDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let d = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: d)
        }
        return self
    }
}
