//
//  CollectionViewCell.swift
//  SpectorViewParody
//
//  Created by User on 26/10/2017.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire
import AlamofireImage

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayContent(imageUrl: String, title: String) {
        
        videoTitleLabel.text = title
        self.imageActivityIndicator.isHidden = false
        imageActivityIndicator.startAnimating()
        downloadImage(imageUrl).then{ resultImage -> Void in
            self.imageView.image = resultImage
            
            }.always {
                self.imageActivityIndicator.stopAnimating()
                self.imageActivityIndicator.isHidden = true
        }
    }
    
    private func downloadImage (_ imageUrl: String) -> Promise<UIImage>{
        return Promise{ fulfill, reject in
            if (imageView.image != nil) {
                fulfill(imageView.image!)
            }else{
                Alamofire.request(imageUrl).validate().responseImage { response in
                    switch response.result{
                    case .success(let value):
                        
                        fulfill(value as UIImage)
                        
                    case .failure(let error):
                        print(error)
                        reject(error)
                    }
                    
                }
                
            }
        }
    }
}
