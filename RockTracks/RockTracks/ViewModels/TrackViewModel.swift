//
//  TrackViewModel.swift
//  RockTracks
//
//  Created by Henry Tsang on 30/05/2024.
//

import Foundation

class TrackViewModel: ObservableObject {
    @Published var tracks = [Track]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchTracks() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedTracks = try await networkService.fetchTracks()
                DispatchQueue.main.async {
                    self.tracks = self.sortTracksByReleaseDate(fetchedTracks)
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Failed to fetch tracks: \(error.localizedDescription)"
                }
            }
        }
    }
    
    private func sortTracksByReleaseDate(_ tracks: [Track]) -> [Track] {
        return tracks.sorted { track1, track2 in
            guard let date1 = track1.releaseDate?.toDate(), let date2 = track2.releaseDate?.toDate() else {
                return false
            }
            return date1 > date2
        }
    }
}

extension String {
    func toDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: self)
    }
}
