//
//  ContentView.swift
//  RockTracks
//
//  Created by Henry Tsang on 30/05/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TrackViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading tracks...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.tracks) { track in
                        NavigationLink(destination: TrackDetailView(viewModel: TrackDetailViewModel(track: track))) {
                            TrackRow(track: track)
                        }
                    }
                }
            }
            .navigationTitle("Rock Tracks")
            .onAppear {
                viewModel.fetchTracks()
            }
        }
    }
}

struct TrackRow: View {
    let track: Track
    
    var body: some View {
        HStack {
            if let artworkUrl = track.artworkUrl100 {
                AsyncImage(url: artworkUrl) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.gray)
                }
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            }
            VStack(alignment: .leading) {
                Text(track.trackName)
                    .font(.headline)
                Text(track.artistName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if let price = track.trackPrice {
                    Text("$\(price, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 5)
    }
}
