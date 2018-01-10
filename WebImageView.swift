//
// Created by Boshi Li on 2018-01-09.
// Copyright (c) 2018 Boshi Li. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class WebImageView: UIImageView {

    var imageUrlString: String?

    var task: URLSessionTask?

    func load(fromURLString urlString: String, enableAnimation: Bool, defaultImage: UIImage, animationOptions: UIViewAnimationOptions = .transitionCrossDissolve) {
        self.imageUrlString = urlString
        self.image = defaultImage

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            image = imageFromCache
            return
        }

        guard var request = urlString.asURLRequest() else { return }
        request.httpMethod = "GET"
        self.task = InternetUtil.shared.creatTask(withURLRequest: request) { [weak self] data, url, error in
            guard let weakSelf = self else {return}
            if error != nil {
                error?.errorHandler()
            } else if let responseURL = url {
                guard responseURL.absoluteString == urlString else {return}
                guard data != nil else {return}
                guard let imageToCache = UIImage(data: data!) else { return }

                if weakSelf.imageUrlString == urlString {
                    if enableAnimation {
                        UIView.transition(with: weakSelf, duration: 0.3, options: animationOptions, animations: {
                            weakSelf.image = imageToCache
                        }, completion: nil)
                    } else {
                        weakSelf.image = imageToCache
                    }
                }
                imageCache.setObject(imageToCache, forKey: responseURL.absoluteString as NSString)
            }
        }
        self.task?.resume()
    }
}
