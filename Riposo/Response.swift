//
//  Response.swift
//  Riposo
//
//  Copyright © 2018 Dot First. All rights reserved.
//

import Foundation

public struct Response {
    
    //MARK: Properties
    public private(set) var status: Status,
                            data: Data?,
                            json: Any?,
                            headers: [String: Any]?,
                            error: Error?,
                            request: URLRequest?
    
    //MARK: Initializers
    public init(code: Int, data: Data?, error: Error?) {
        self.status = Status(code: code)
        self.data = data
        self.error = error
    }
    
    public init(code: Int, json: Any?, error: Error?) {
        self.status = Status(code: code)
        self.json = json
        self.error = error
    }
    
    public init(code: Int, data: Data?, json: Any?, headers: [String: Any]?, error: Error?, request: URLRequest?) {
        self.status = Status(code: code)
        self.data = data
        self.json = json
        self.headers = headers
        self.error = error
        self.request = request
    }
    
}
