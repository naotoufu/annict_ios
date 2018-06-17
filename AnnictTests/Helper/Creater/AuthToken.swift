//
//  AuthToken.swift
//  AnnictTests
//
//  Created by 伊東直人 on 2018/06/17.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
@testable import Annict

extension AuthToken {
    static func createAuthTokenArray(numberOfElements: Int = 2) -> [AuthToken] {
        var authTokens = [AuthToken]()
        
        for i in 0..<numberOfElements {
            let authToken = createAuthToken(index: i)
            authTokens.append(authToken)
        }
        
        return authTokens
    }
    
    static func createAuthToken(index: Int = 0) -> AuthToken {
        return AuthToken(accessToken: "abcdejf.123456", tokenType: "code", scope: "scope", createdAt: Int(Date().timeIntervalSinceNow))
    }
}
