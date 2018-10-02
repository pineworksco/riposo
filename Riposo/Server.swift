//
//  Server.swift
//  Riposo
//
//  Copyright © 2018 Dot First. All rights reserved.
//

import Foundation

//MARK: - HTTPMethod
public enum HTTPMethod: String {
    case get = "GET",
         post = "POST",
         patch = "PATCH",
         put = "PUT",
         delete = "DELETE"
}

//MARK: - Server
public class Server {
    static let delegate = ServerDelegate(),
               session = URLSession(configuration: URLSessionConfiguration.default, delegate: Server.delegate, delegateQueue: nil)
    
    //MARK: - Properties
    public var url: URL,
               defaultHeaders: [String: Any]
    
    //MARK: - Instance Methods
    public init(url: URL, headers: [String: Any] = [String: Any]()) {
        self.url = url
        self.defaultHeaders = headers
    }
    
    //MARK: - Utility Methods
    public class func request(method: HTTPMethod, url: URL, parameters: [String: Any]?, headers: [String: Any]?, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        var request = URLRequest(url: url)
        
        if let parameters = parameters {
            if (method == .get) {
                request.url = request.url?.appendingQueryParameters(parameters: parameters)
            } else {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    request.httpBody = nil
                }
            }
        }
        
        if let headers = headers {
            for (headerKey, headerValue) in headers {
                request.addValue(headerValue as! String, forHTTPHeaderField: headerKey)
            }
        }
        
        Server.session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Response Error: \(error)")
            }
            
            if let data = data, let httpResponse = response as? HTTPURLResponse {
                var json: [String: Any]?
                
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                } catch {
                    print("JSON read error: \(error)")
                }
                
                DispatchQueue.main.async {
                    completionHandler(Response(code: httpResponse.statusCode, json: json, headers: httpResponse.allHeaderFields as? [String : Any], error: error))
                }
            }
        }.resume()
    }
    
    public class func get(url: URL, parameters: [String: Any]?, headers: [String: Any]?, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        request(method: .get, url: url, parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    public class func post(url: URL, parameters: [String: Any]?, headers: [String: Any]?, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        request(method: .post, url: url, parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    public class func patch(url: URL, parameters: [String: Any]?, headers: [String: Any]?, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        request(method: .patch, url: url, parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    public class func put(url: URL, parameters: [String: Any]?, headers: [String: Any]?, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        request(method: .put, url: url, parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    public class func delete(url: URL, parameters: [String: Any]?, headers: [String: Any]?, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        request(method: .delete, url: url, parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
}
