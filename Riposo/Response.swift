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
                            json: [String: Any]?,
                            headers: [String: Any]?,
                            error: Error?
    
    //MARK: Initializers
    public init(code: Int, json: [String: Any]?, error: Error?) {
        self.status = Status(code: code)
        self.json = json
        self.error = error
    }
    
    public init(code: Int, json: [String: Any]?, headers: [String: Any]?, error: Error?) {
        self.status = Status(code: code)
        self.json = json
        self.headers = headers
        self.error = error
    }
    
}
