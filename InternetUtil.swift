//
// Created by Boshi Li on 2018-01-09.
// Copyright (c) 2018 Boshi Li. All rights reserved.
//

import Foundation

typealias JsonNode = [String:Any]

enum InternetError: Error {
    case badResponse(statusCode: Int)
    case abort(message: String)
    case parseJsonFailed(message: String)
    
    func errorHandler() {
        switch self {
        case .badResponse(let statusCode):
            print(statusCode)
        case .abort(let message):
            print(message)
        case .parseJsonFailed(let message):
            print(message)
        }
    }
}

struct InternetUtil {

    static let shared = InternetUtil()

    func creatTask(withURLRequest request: URLRequest, responseHandler: @escaping (Data?, URL?, InternetError?) -> Swift.Void) -> URLSessionTask  {

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: request) { (responseData: Data?, urlResponse: URLResponse?, error: Error?) -> Void in
            guard error == nil else {
                DispatchQueue.main.async {
                    responseHandler(nil, request.url, InternetError.abort(message: error!.localizedDescription))
                }
                return
            }
            guard let response = urlResponse as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    responseHandler(nil, request.url, InternetError.abort(message: "Cast response failed"))
                }
                return
            }
            guard response.statusCode == 200 || response.statusCode == 304 else {
                let badResponse: InternetError = .badResponse(statusCode: response.statusCode)
                DispatchQueue.main.async {
                    responseHandler(nil, request.url, badResponse)
                }
                return
            }
            guard let data = responseData else {
                let badResponse: InternetError = .abort(message: "Data might be missing!")
                DispatchQueue.main.async {
                    responseHandler(nil, request.url, badResponse)
                }
                return
            }
            DispatchQueue.main.async {
                responseHandler(data, response.url, nil)
            }
         }
        return task
    }

}

extension String{
    
    func asURLRequest()->URLRequest?{
        var urlRequest:URLRequest?
        if self.isValidForUrl(){
            if let url = URL(string: self){
                urlRequest = URLRequest(url: url)
            }
        }else{
            urlRequest = nil
        }
        return urlRequest
    }
    
    func isValidForUrl() -> Bool {
        
        if(self.hasPrefix("http") || self.hasPrefix("https")) {
            return true
        }
        return false
    }
}
