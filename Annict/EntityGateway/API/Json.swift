//
//  Json.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

/**
 Extension on `Dictionary` that adds different helper methods such as JSON `Data` serialization
 */
public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any  {
    
    /**
     Heper method that serializes the `Dictionary` to JSON `Data`
     
     - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
     */
    public func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}

/**
 Extension on `Array` that adds different helper methods such as JSON `Data` serialization
 */
public extension Array where Element: Any {
    /**
     Heper method that serializes the `Array` to JSON `Data`
     
     - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
     */
    public func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}
