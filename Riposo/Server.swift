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
    public init(_ url: URL, headers: [String: Any] = [String: Any]()) {
        self.url = url
        self.defaultHeaders = headers
    }
    
    public func get(_ path: String? = nil, parameters: [String: Any]? = nil, headers: [String: Any]? = nil, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        Server.get(url: url.appendingPathComponent(path ?? ""), parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    public func post(_ path: String? = nil, parameters: [String: Any]? = nil, headers: [String: Any]? = nil, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        Server.post(url: url.appendingPathComponent(path ?? ""), parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    public func patch(_ path: String? = nil, parameters: [String: Any]? = nil, headers: [String: Any]? = nil, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        Server.patch(url: url.appendingPathComponent(path ?? ""), parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    public func put(_ path: String? = nil, parameters: [String: Any]? = nil, headers: [String: Any]? = nil, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        Server.put(url: url.appendingPathComponent(path ?? ""), parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    public func delete(_ path: String? = nil, parameters: [String: Any]? = nil, headers: [String: Any]? = nil, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        Server.delete(url: url.appendingPathComponent(path ?? ""), parameters: parameters, headers: headers, completionHandler: completionHandler)
    }
    
    //MARK: - Utility Methods
    public class func request(method: HTTPMethod, url: URL, parameters: [String: Any]?, headers: [String: Any]?, completionHandler: @escaping (Response?) -> () = {(_: Response?) -> () in }) {
        var request = URLRequest(url: url)
        
        if let parameters = parameters {
            if (method == .get) {
                request.url?.appendQueryParameters(parameters: parameters)
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
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(Response(code: 0, json: nil, headers: nil, error: error))
                }
                return
            }
            var json: [String: Any]?
            if let data = data {
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                } catch {
                    debugPrint("JSON read error: \(error)")
                }
            }
            DispatchQueue.main.async {
                completionHandler(Response(code: httpResponse.statusCode, json: json, headers: httpResponse.allHeaderFields as? [String : Any], error: error))
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
