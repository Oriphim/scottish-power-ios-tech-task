//
//  TrackDetailViewModel.swift
//  RockTracks
//
//  Created by Henry Tsang on 30/05/2024.
//

import Foundation

class TrackDetailViewModel: ObservableObject {
    @Published var track: Track
    
    init(track: Track) {
        self.track = track
    }
    
    var trackName: String {
        track.trackName
    }
    
    var artistName: String {
        track.artistName
    }
    
    var trackPrice: String {
        if let price = track.trackPrice {
            return String(format: "$%.2f", price)
        }
        return "N/A"
    }
    
    var artworkUrl: URL? {
        track.artworkUrl100
    }
    
    var duration: String {
        if let duration = track.trackTimeMillis {
            return formatDuration(duration)
        }
        return "N/A"
    }
    
    var releaseDate: String {
        if let releaseDate = track.releaseDate {
            return formatReleaseDate(releaseDate)
        }
        return "N/A"
    }
    
    var trackViewUrl: URL? {
        track.trackViewUrl
    }
    
    private func formatDuration(_ duration: Int) -> String {
        let minutes = duration / 60000
        let seconds = (duration % 60000) / 1000
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private func formatReleaseDate(_ releaseDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: releaseDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return releaseDate
    }
}

