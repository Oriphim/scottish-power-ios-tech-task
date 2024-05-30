//
//  TrackDetailView.swift
//  RockTracks
//
//  Created by Henry Tsang on 30/05/2024.
//

import SwiftUI

struct TrackDetailView: View {
    @StateObject var viewModel: TrackDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let artworkUrl = viewModel.artworkUrl {
                AsyncImage(url: artworkUrl) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(.gray)
                }
                .frame(width: 100, height: 100)
                .cornerRadius(16)
                .padding()
                .frame(maxWidth: .infinity)
            }
            
            Text(viewModel.trackName)
                .font(.title)
                .fontWeight(.bold)
            
            Text(viewModel.artistName)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Price: \(viewModel.trackPrice)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Duration: \(viewModel.duration)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Release Date: \(viewModel.releaseDate)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            if let trackViewUrl = viewModel.trackViewUrl {
                Button(action: {
                    UIApplication.shared.open(trackViewUrl)
                }) {
                    Text("More details")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .padding()
            }
        }
        .padding()
    }
}

