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
    var receiveOAuthTokenResultToBeReturned: Result<AuthToken>!
    
    func receiveOauthToken(code: String, completionHandler: @escaping ReceiveOauthTokenEntityGatewayCompletionHandler) {
        completionHandler(receiveOAuthTokenResultToBeReturned)
    }
    
}
