//
//  Work.swift
//  AnnictTests
//
//  Created by 伊東直人 on 2018/06/24.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
@testable import Annict

extension Work {
    static func createWorksArray(numberOfElements: Int = 2) -> [Work] {
        var works = [Work]()
        
        for i in 0..<numberOfElements {
            let work = createWork(index: i)
            works.append(work)
        }
        
        return works
    }
    
    static func createWork(index: Int = 0) -> Work {
        let facebook = Facebook(ogImageUrl: "ogImageUrl \(index)")
        let twitter = Twitter(miniAvatarUrl: "miniAvatarUrl \(index)", normalAvatarUrl: "normalAvatarUrl \(index)", biggerAvatarUrl: "biggerAvatarUrl \(index)", originalAvatarUrl: "originalAvatarUrl \(index)", imageUrl: "originalAvatarUrl \(index)")
        let images = Images(facebook: [facebook], twitter: [twitter], recommendedUrl: "recommendedUrl \(index)")
        
        return Work(id: index, title: "title \(index)", titleKana: "titleKana \(index)", media: "media \(index)", mediaText: "mediaText \(index)", seasonName: "seasonName \(index)", seasonNameText: "seasonNameText \(index)", releasedOn: Date(), releasedOnAbout: Date(), officialSiteUrl: "officialSiteUrl \(index)", wikipediaUrl: "wikipediaUrl \(index)", twitterUsername: "twitterUsername \(index)", twitterHashtag: "twitterHashtag \(index)", malAnimeId: "malAnimeId \(index)", images: [images], episodesCount: index, watchersCount: index, reviewsCount: index, noEpisodes: false)
    }
}
