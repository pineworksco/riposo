//
//  URL.swift
//  Riposo
//
//  Copyright © 2018 Dot First. All rights reserved.
//

import Foundation

public extension URL {
    public static func stringFromParameters(parameters: [String: Any]) -> String {
        var parameterArray = [String]()
        for (key, value) in parameters {
            parameterArray.append("\(key)=\(value)")
        }
        
        return parameterArray.joined(separator: "&")
    }
    
    public static func parametersFromString(string: String) -> [String: Any] {
        var parsed = [String: Any]()
        let parameters = string.components(separatedBy: "&")
        for parameter in parameters {
            let parameterPieces = parameter.components(separatedBy: "=")
            parsed[parameterPieces[0]] = parameterPieces[1]
        }
        return parsed
    }
    
    public func appendingQueryParameters(parameters: [String: Any]) -> URL {
        var mergedParameters = queryParameters
        
        for (parameterKey, parameterValue) in parameters {
            mergedParameters.updateValue(parameterValue, forKey: parameterKey)
        }
        if (parameters.count == 0) {
            return self
        }
        
        return URL(string: "\(absoluteString.split(separator: "?")[0])?\(URL.stringFromParameters(parameters: mergedParameters))")!
    }
    
    mutating public func appendQueryParameters(parameters: [String: Any]) {
        self = appendingQueryParameters(parameters: parameters)
    }
    
    public var queryParameters: [String: Any] {
        get {
            guard let query = query else { return [String: String]() }
            return URL.parametersFromString(string: query)
        }
    }
}
