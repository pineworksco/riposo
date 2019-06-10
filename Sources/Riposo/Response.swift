//
//  Response.swift
//  Riposo - https://github.com/dotfirst/riposo
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
    
    //MARK: - Status
    public struct Status {
        
        //MARK: Properties
        public let code: Int,
                   classification: CodeClassification,
                   type: CodeType
        
        //MARK: Initializers
        public init(code: Int) {
            self.code = code
            switch (code) {
                case 100..<200:
                    self.classification = .informational
                case 200..<300:
                    self.classification = .success
                case 300..<400:
                    self.classification = .redirection
                case 400..<500:
                    self.classification = .clientError
                default:
                    self.classification = .serverError
            }
            
            if let foundType = CodeType(rawValue: code) {
                self.type = foundType
            } else {
                self.type = .unknown
            }
        }
        
        
        public enum CodeClassification: Int {
            case informational = 100,
            success = 200,
            redirection = 300,
            clientError = 400,
            serverError = 500
        }
        
        public enum CodeType: Int {
            case unknown = 0,
            cont = 100,
            switchingProtocols = 101,
            processing = 102,
            ok = 200,
            created = 201,
            accepted = 202,
            nonAuthoritativeInformation = 203,
            noContent = 204,
            resetContent = 205,
            partialContent = 206,
            multiStatus = 207,
            alreadyReported = 208,
            imUsed = 226,
            multipleChoices = 300,
            movedPermanently = 301,
            found = 302,
            seeOther = 303,
            notModified = 304,
            useProxy = 305,
            switchProxy = 306,
            temporaryRedirect = 307,
            permanentRedirect = 308,
            badRequest = 400,
            unauthorized = 401,
            paymentRequired = 402,
            forbidden = 403,
            notFound = 404,
            methodNotAllowed = 405,
            notAcceptable = 406,
            proxyAuthenticationRequired = 407,
            requestTimeout = 408,
            conflict = 409,
            gone = 410,
            lengthRequired = 411,
            preconditionFailed = 412,
            requestEntityTooLarge = 413,
            requestURITooLong = 414,
            unsupportedMediaType = 415,
            requestedRangeNotSatisfiable = 416,
            expectationFailed = 417,
            enhanceYourCalm = 420,
            unprocessableEntity = 422,
            locked = 423,
            failedDependency = 424,
            upgradeRequired = 426,
            preconditionRequired = 428,
            tooManyRequests = 429,
            requestHeaderFieldsTooLarge = 431,
            noResponse = 444,
            unavailableForLegalReasons = 451,
            requestHeaderTooLarge = 494,
            certError = 495,
            noCert = 496,
            httpToHTTPS = 497,
            clientClosedRequest = 499,
            internalServerError = 500,
            notImplemented = 501,
            badGateway = 502,
            serviceUnavailable = 503,
            gatewayTimeout = 504,
            httpVersionNotSupported = 505,
            variantAlsoNegotiates = 506,
            insufficientStorage = 507,
            loopDetected = 508,
            bandwidthLimitExceeded = 509,
            notExtended = 510,
            networkAuthenticationRequired = 511,
            networkReadTimeoutError = 598,
            networkConnectTimeoutError = 599
        }
    }

    
}
