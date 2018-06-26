//
//  CoreDataWork.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
import CoreData

// It's best to decouple the application / business logic from your persistence framework
// That's why CoreDataWork - which is a NSManagedObjectModel subclass is converted into a Work entity
extension CoreDataWork {
    var work: Work {
        return Work(id: Int(id), title: title ?? "", titleKana: titleKana ?? "", media: media ?? "", mediaText: mediaText ?? "", seasonName: seasonName ?? "", seasonNameText: seasonNameText ?? "", releasedOn: releasedOn as Date?, releasedOnAbout: releasedOnAbout as Date?, officialSiteUrl: officialSiteUrl ?? "", wikipediaUrl: wikipediaUrl ?? "", twitterUsername: twitterUsername ?? "", twitterHashtag: twitterHashtag ?? "", malAnimeId: malAnimeId ?? "", images: images as! Images?, episodesCount: Int(episodesCount), watchersCount: Int(watchersCount), reviewsCount: Int(reviewsCount), noEpisodes: noEpisodes)
    }
    
    func populate(with parameters: AddWorkParameters) {
        // Normally this id should be used at some point during the sync with the API backend
        id = Int64(parameters.id)
        title = parameters.title
    }
    
    func populate(with work: Work) {
        id = Int64(work.id)
        title = work.title
    }
}
