//
//  Work.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/23.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
struct Work {

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

    

//    var durationToReadInHours: Double {
//        // Let's pretend it takes one hour to read 30 pages.
//        // This is what we would usually call business logic - that is logic that is "true" across multiple applications
//        // It's true however that usually this would be returned by the API as most of the business logic usually sits on the API side
//        return Double(pages) / 30.0
//    }
}

extension Work: Equatable { }

struct Images {
    var facebook : Facebook?
    var twitter : Twitter?
    var recommendedUrl : String? // facebook.og_image_url, twitter.bigger_avatar_url, twitter.image_url のうち、解像度が一番大きい画像のURL。扱いやすい画像のURLが高確率で格納されるプロパティになります
}

// official_site_url のページで取得できる og:image のURL
struct Facebook {
    var ogImageUrl : String?
}

// Twitterアカウントのアバター画像。mini, normal, bigger, original の4種類のサイズがあります
// official_site_url のページで取得できる twitter:image のURL
struct Twitter {
    var miniAvatarUrl : String?
    var normalAvatarUrl : String?
    var biggerAvatarUrl : String?
    var originalAvatarUrl : String?
    var imageUrl : String?
}

func == (lhs: Work, rhs: Work) -> Bool {
    return lhs.id == rhs.id
}
