//
//  AuthTokenGateWay.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

typealias ReceiveOauthTokenEntityGatewayCompletionHandler = (_ authToken: Result<AuthToken>) -> Void

protocol AuthTokenGateway {
    func receiveOauthToken(code: String, completionHandler: @escaping ReceiveOauthTokenEntityGatewayCompletionHandler)
}
