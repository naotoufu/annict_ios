//
//  ApiWork.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
// If your company develops the API then it's relatively safe to have a single representation
// for both the API entities and your core entities. So depending on the complexity of your app this entity might be an overkill
struct ApiWork: InitializableWithData, InitializableWithJson {
    var id : Int  // 作品のID
    var title : String   // 作品のタイトル
    var titleKana : String //  作品タイトルの読み仮名
    var media : String // リリース媒体 tv, ova, movie, web, other
    var mediaText : String // リリース媒体 (表記用) TV, OVA, 映画, Web, その他
    var seasonName : String? // リリース時期
    var seasonNameText : String? // リリース時期 (表記用)
    var releasedOn : Date? // リリース日
    var releasedOnAbout : Date? // 未確定な大体のリリース日
    var officialSiteUrl : String? // 公式サイトのURL
    var wikipediaUrl : String? // WikipediaのURL
    var twitterUsername : String? // 公式Twitterアカウントのusername
    var twitterHashtag : String? // Twitterの作品に関するハッシュタグ
    var malAnimeId : String? // MyAnimeListの作品ID
    var images : Images? // image URLs
    var episodesCount : Int // エピソード数
    var watchersCount : Int // 見てる / 見たい / 見た人の数
    var reviewsCount : Int // レビュー数
    var noEpisodes : Bool // エピソードが存在しない作品かどうか。例えば映画はエピソードが存在しない作品なので、true になります

    
    init(data: Data?) throws {
        // Here you can parse the JSON or XML using the build in APIs or your favorite libraries
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? [String: Any] else {
                throw NSError.createPraseError()
        }
        
        try self.init(json: json)
        
    }
    
    init(json: [String : Any]) throws {
        guard let id = json["id"] as? Int,
            let title = json["title"] as? String,
            let titleKana = json["title_kana"] as? String,
            let media = json["media"] as? String,
            let mediaText = json["media_text"] as? String,
            let seasonName = json["season_name"] as? String,
            let seasonNameText = json["season_name_text"] as? String,
            let releasedOn = json["released_on"] as? String,
            let releasedOnAbout = json["released_on_about"] as? String,
            let officialSiteUrl = json["official_site_url"] as? String,
            let wikipediaUrl = json["wikipedia_url"] as? String,
            let twitterUsername = json["twitter_username"] as? String,
            let twitterHashtag = json["twitter_hashtag"] as? String,
            let malAnimeId = json["mal_anime_id"] as? String,
            let images = json["images"] as? [String:Any],
            let episodesCount = json["episodes_count"] as? Int,
            let watchersCount = json["watchers_count"] as? Int,
            let reviewsCount = json["reviews_count"] as? Int,
            let noEpisodes = json["no_episodes"] as? Bool else {
                throw NSError.createPraseError()
        }
        
        self.id = id
        self.title = title
        self.titleKana = titleKana
        self.media = media
        self.mediaText = mediaText
        self.seasonName = seasonName
        self.seasonNameText = seasonNameText
        
        // convert string to Date
        let dateFormatter = DateFormatter()
        let releasedOnDate = dateFormatter.date(fromNASAString: releasedOn)
        self.releasedOn = releasedOnDate
        
        // convert string to Date
        let releasedOnAboutDate = dateFormatter.date(fromNASAString: releasedOnAbout)
        self.releasedOnAbout = releasedOnAboutDate
        
        self.officialSiteUrl = officialSiteUrl
        self.wikipediaUrl = wikipediaUrl
        self.twitterUsername = twitterUsername
        self.twitterHashtag = twitterHashtag
        self.malAnimeId = malAnimeId
        // convert [[Setring: String]] to [Images]
        var imagesObject = Images()
        for image in images {
            if let value = image.value as? String  {
                imagesObject.recommendedUrl = value
            } else if let value = image.value as? [String : String] {
                switch image.key {
                case "facebook":
                    imagesObject.facebook = Facebook()
                    imagesObject.facebook?.ogImageUrl = value["og_image_url"]
                case "twitter":
                    imagesObject.twitter = Twitter()
                    imagesObject.twitter?.biggerAvatarUrl = value["bigger_avatar_url"]
                    imagesObject.twitter?.miniAvatarUrl = value["mini_avatar_url"]
                    imagesObject.twitter?.normalAvatarUrl = value["normal_avatar_url"]
                    imagesObject.twitter?.originalAvatarUrl = value["original_avatar_url"]
                    imagesObject.twitter?.imageUrl = value["image_url"]
                default:
                    break
                }
            }
        }
        self.images = imagesObject
        self.episodesCount = episodesCount
        self.watchersCount = watchersCount
        self.reviewsCount = reviewsCount
        self.noEpisodes = noEpisodes
    }
}

extension ApiWork {
    var work: Work {
        return Work(id : id,
                    title : title,
                    titleKana : titleKana,
                    media : media,
                    mediaText : mediaText,
                    seasonName : seasonName,
                    seasonNameText : seasonNameText,
                    releasedOn : releasedOn,
                    releasedOnAbout : releasedOnAbout,
                    officialSiteUrl : officialSiteUrl,
                    wikipediaUrl : wikipediaUrl,
                    twitterUsername : twitterUsername,
                    twitterHashtag : twitterHashtag,
                    malAnimeId : malAnimeId,
                    images : images,
                    episodesCount : episodesCount,
                    watchersCount : watchersCount,
                    reviewsCount : reviewsCount,
                    noEpisodes : noEpisodes)
    }
}
