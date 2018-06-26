//
//  DateFormatter.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/25.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

extension DateFormatter {
    func date(fromNASAString dateString: String) -> Date? {
        // looks like: "2016-05-25"
        self.dateFormat = "yyyy-MM-dd"
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        return self.date(from: dateString)
    }
}
