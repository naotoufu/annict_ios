//
//  URLSessionStub.swift
//  AnnictTests
//
//  Created by 伊東直人 on 2018/06/11.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import XCTest
@testable import Annict

class URLSessionStub: URLSessionProtocol {
    typealias URLSessionCompletionHandlerResponse = (data: Data?, response: URLResponse?, error: Error?)
    var responses = [URLSessionCompletionHandlerResponse]()
    
    func enqueue(response: URLSessionCompletionHandlerResponse) {
        responses.append(response)
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return StubTask(response: responses.removeFirst(), completionHandler: completionHandler)
    }
    
    private class StubTask: URLSessionDataTask {
        let testDoubleResponse: URLSessionCompletionHandlerResponse
        let completionHandler: (Data?, URLResponse?, Error?) -> Void
        
        init(response: URLSessionCompletionHandlerResponse, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
            self.testDoubleResponse = response
            self.completionHandler = completionHandler
        }
        
        override func resume() {
            completionHandler(testDoubleResponse.data, testDoubleResponse.response, testDoubleResponse.error)
        }
    }
}

extension URL {
    static var googleUrl: URL {
        return URL(string: "https://www.google.com")!
    }
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: URL.googleUrl, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
    
}
