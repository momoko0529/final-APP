//
//  Song.swift
//  MusicApp
//
//  Created by SHIH-YING PAN on 2019/11/27.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import Foundation

struct Song: Codable {
    var artistName: String
    var trackName: String
    var previewUrl: URL
    var artworkUrl100: URL
    var trackPrice: Double?
    var collectionName: String?

}

struct SongResults: Codable {
    var resultCount: Int
    var results: [Song]
}
