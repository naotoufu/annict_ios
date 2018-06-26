//
//  Consts.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
class AnnictConsts {
    
    static let rootURI = "https://api.annict.com"
    
    static let redirectURI = "jp.annict.uaw://oauth"
    
    static var clientID: String {
        return "5318b4593e12f28f17f49bfae594073d6b440b5cf31f6e4aa049cb3c28cdadb3"
    }
    
    static var clientSecret: String {
        return "d3ce111988fac97c75b705533ef5623138af26cbbed7c5475e2eb027a7cb3ee5"
    }
    
    static func oauthURL() -> URL? {
        var oauthURL = "/oauth/authorize"
        oauthURL += "?client_id=\(AnnictConsts.clientID)"
        oauthURL += "&response_type=code"
        oauthURL += "&redirect_uri=\(redirectURI)"
        oauthURL += "&scope=read+write"
        return URL(string: oauthURL, relativeTo: URL(string: AnnictConsts.rootURI))
    }
}
