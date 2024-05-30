//
//  Track.swift
//  RockTracks
//
//  Created by Henry Tsang on 30/05/2024.
//

import Foundation
    
struct Track: Codable, Identifiable {
    var id: String {
        return trackId
    }
    let trackId: String
    let trackName: String
    let artistName: String
    let trackPrice: Double?
    let artworkUrl100: String?
}

