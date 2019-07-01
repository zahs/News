//
//  LoaderCell.swift
//  News
//
//  Created by Zhanna Sargsyan on 29/06/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import Foundation
import UIKit

class LoaderCell : UICollectionViewCell {
  
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    func animateLoader(_ shoudLoad: Bool) {
        onMain() {
            if shoudLoad {
                self.loadingIndicator.startAnimating()
            } else {
                self.loadingIndicator.stopAnimating()
            }
        }
    }
}
