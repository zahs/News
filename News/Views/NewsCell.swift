//
//  NewsCell.swift
//  News
//
//  Created by Zhanna Sargsyan on 28/06/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation
import UIKit

class NewsCell : UICollectionViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func updateCell(with newsData: NewsData) {
        self.titleLabel.text = newsData.title
        self.dateLabel.text = newsData.publishedAt
        self.authorLabel.text = newsData.author
        if let url = URL(string: newsData.urlToImage) {
            loadImageFromURL(url: url) { (data) in
                onMain {
                    if let d = data {
                        self.icon.image = UIImage(data:d)
                    }
                }
            }
        }
    }
}
