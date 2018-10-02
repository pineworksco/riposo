//
//  Status.swift
//  Riposo
//
//  Copyright © 2018 Dot First. All rights reserved.
//

import Foundation

public enum StatusClassification: Int {
    case informational = 100,
         success = 200,
         redirection = 300,
         clientError = 400,
         serverError = 500
}

public enum StatusType: Int {
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

public struct Status {
    
    //MARK: Properties
    public let code: Int,
               classification: StatusClassification,
               type: StatusType
    
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
        
        if let foundType = StatusType(rawValue: code) {
            self.type = foundType
        } else {
            self.type = .unknown
        }
    }
    
}
