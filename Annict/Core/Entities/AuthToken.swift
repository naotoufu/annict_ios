//
//  AuthToken.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

struct AuthToken {
    var accessToken: String
    var tokenType: String
    var scope: String
    var createdAt: Int
}

extension AuthToken: Equatable { }

func == (lhs: AuthToken, rhs: AuthToken) -> Bool {
    return lhs.accessToken == rhs.accessToken
}
