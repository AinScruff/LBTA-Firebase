//
//  ImageService.swift
//  LBTA-Firebase
//
//  Created by Dominique Michael Abejar on 9/1/20.
//  Copyright © 2020 NinjaTuna. All rights reserved.
//

import Foundation
import UIKit

class ImageService {
    
    static fileprivate let cache = NSCache<NSString, UIImage>()
    
    static fileprivate func downloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
            var downloadedImage: UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        
        dataTask.resume()
    }
    
    static func getImage(withURL url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            downloadImage(withURL: url, completion: completion)
        }
    }
}
