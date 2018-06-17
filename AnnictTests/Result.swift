//
//  Result.swift
//  AnnictTests
//
//  Created by 伊東直人 on 2018/06/17.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
@testable import Annict

extension Result: Equatable { }

public func ==<T>(lhs: Result<T>, rhs: Result<T>) -> Bool {
    // Shouldn't be used for PRODUCTION enum comparison. Good enough for unit tests.
    return String(stringInterpolationSegment: lhs) == String(stringInterpolationSegment: rhs)
}
