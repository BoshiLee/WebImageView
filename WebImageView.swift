//
// Created by Boshi Li on 2018-01-09.
// Copyright (c) 2018 Boshi Li. All rights reserved.
//

import UIKit

private let imageCache = NSCache<NSURLRequest, UIImage>()

public class WebImageView: UIImageView {
    
    public struct Configuration {
        var placeholderImage: UIImage? = nil
        var animationDuration: TimeInterval = 0.3
        var animationOptions: UIViewAnimationOptions = .transitionCrossDissolve
    }
    
    private var currentTask: URLSessionTask? {
        didSet {
            oldValue?.cancel()
            currentTask?.resume()
        }
    }
    
    public var configuration = Configuration()
    
    public func load(request: URLRequest?) {
        guard let request = request else {
            currentTask = nil
            return
        }
        if let imageFromCache = imageCache.object(forKey: request as NSURLRequest) {
            image = imageFromCache
            return
        } else {
            image = configuration.placeholderImage
        }
        currentTask = URLSession.shared.dataTask(with: request) { [weak self] (data, _, error) in
            guard let imageView = self else { return }
            if let error = error {
                print("Network Error: ", error)
            }
            guard imageView.currentTask?.originalRequest == request else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            let configuration = imageView.configuration
            DispatchQueue.main.async {
                UIView.transition(with: imageView, duration: configuration.animationDuration, options: configuration.animationOptions, animations: {
                    imageView.image = image
                }, completion: nil)
                imageCache.setObject(image, forKey: request as NSURLRequest)
            }
        }
    }
    
}

