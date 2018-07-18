//
//  CacheAuthTokenGatewayTest.swift
//  AnnictTests
//
//  Created by 伊東直人 on 2018/06/17.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import XCTest
@testable import Annict

class CacheAuthTokenGatewayTest: XCTestCase {
    // https://www.martinfowler.com/bliki/TestDouble.html
    var apiAuthTokenGatewaySpy = ApiAuthTokenGatewaySpy()
    
    var cacheAuthTokenGateway: CacheAuthTokenGateway!
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        cacheAuthTokenGateway = CacheAuthTokenGateway(apiAuthTokenGateway: apiAuthTokenGatewaySpy)
    }
    
    // MARK: - Tests
    
    func test_fetchAuthToken_api_success() {
        // Given
        let code = "9999"
        let authTokenToReturn = AuthToken.createAuthToken()
        let expectedResultToBeReturned: Result<AuthToken> = .success(authTokenToReturn)
        
        apiAuthTokenGatewaySpy.receiveOAuthTokenResultToBeReturned = expectedResultToBeReturned
        
        let fetchAuthTokenCompletionHandlerExpectation = expectation(description: "Fetch AuthToken completion handler expectation")
        
        // When
        cacheAuthTokenGateway.receiveOauthToken(code: code) { (result) in
            // Then
            XCTAssertEqual(expectedResultToBeReturned, result, "The expected result wasn't returned")
            
            fetchAuthTokenCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
