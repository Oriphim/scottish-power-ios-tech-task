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
    
    func fetchTracks() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=rock&entity=song") else {
            self.isLoading = false
            self.errorMessage = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = "Failed to fetch tracks: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let searchResult = try decoder.decode(SearchResult.self, from: data)
                    self.tracks = searchResult.results
                } catch {
                    self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
