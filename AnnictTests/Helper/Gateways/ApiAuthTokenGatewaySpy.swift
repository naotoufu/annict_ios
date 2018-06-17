//
//  ApiAuthTokenGatewaySpy.swift
//  AnnictTests
//
//  Created by 伊東直人 on 2018/06/17.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
@testable import Annict

class ApiAuthTokenGatewaySpy: ApiAuthTokenGateway {
    var sendOAuthTokenResultToBeReturned: Result<AuthToken>!
    
    func sendOauthToken(code: String, completionHandler: @escaping SendOauthTokenEntityGatewayCompletionHandler) {
        completionHandler(sendOAuthTokenResultToBeReturned)
    }
    
}
