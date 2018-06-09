//
//  Result.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/07.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }
    
    var message = ""
}

// See https://github.com/antitypical/Result
enum Result<T> {
    case success(T)
    case failure(Error)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
