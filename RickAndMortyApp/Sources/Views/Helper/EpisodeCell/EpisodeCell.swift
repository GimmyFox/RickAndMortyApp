//
//  EpisodeCell.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 22.08.2023.
//

import SwiftUI

struct EpisodeCell: View {
    @ObservedObject var vm: EpisodeCellViewModel
    
    init(url: String) {
        self._vm = ObservedObject(wrappedValue: EpisodeCellViewModel(url: url))
    }
    var body: some View {
            Group {
                if let model = vm.model {
                    createCell(title: model.name, episode: model.episode, airDate: model.airDate)
                    
                } else {
                    createCell(title: "", episode: "", airDate: "")
                        .hidden()
                        .overlay {
                            ProgressView()
                        }
                }
            }
            .padding()
            .background(Color(UIColor.cardBackground!))
            .cornerRadius(CustomCornerRadius.corner16.rawValue)
            
    }
    
    @ViewBuilder
    func createCell(title: String, episode: String, airDate: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(Font(UIFont.system17normal))
                .foregroundColor(.white)
            HStack {
                Text(episode)
                    .font(Font(UIFont.system13normal))
                    .foregroundColor(Color(UIColor.greenTextColor!))
                Spacer()
                Text(airDate)
                    .font(Font(UIFont.system12normal))
            }
        }
    }
}

