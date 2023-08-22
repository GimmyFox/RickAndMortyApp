//
//  CharacterDescriptionView.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 22.08.2023.
//

import SwiftUI

struct CharacterDescriptionView: View {
    @StateObject var vm: CharacterDescriptionViewModel
    let action: ()->()
    init(characterInfo: CharacterInfo, action: @escaping ()->()) {
        self._vm = StateObject(wrappedValue: CharacterDescriptionViewModel(model: characterInfo))
        self.action = action
    }
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(Font(UIFont.system22normal))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding([.leading, .bottom])
                ScrollView {
                    nameAndImageInfo
                    charInfo
                    if let _ = vm.origin {
                        originInfo
                    }
                    episodesInfo
                }
            }
            
        }
        .background(Color(UIColor.backgroundColor!))
        .overlay {
            if vm.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
    }
    
    
    private func statusColor(status: Status) -> Color {
        switch status {
        case .alive: return Color(UIColor.greenTextColor!)
        case .dead: return .red
        case .unknown: return .orange
        }
    }
    
    private var nameAndImageInfo: some View {
        VStack {
            AsyncImage(url: URL(string: vm.model.image)!) { img in
                if let image = img.image {
                    image
                        .resizable()
                        .frame(width: ImageSize.square148x148.rawValue, height: ImageSize.square148x148.rawValue)
                        .aspectRatio(1/1, contentMode: .fit)
                        .cornerRadius(CustomCornerRadius.corner10.rawValue)
                } else if img.error != nil {
                    RoundedRectangle(cornerRadius: CustomCornerRadius.corner10.rawValue)
                        .frame(width: ImageSize.square148x148.rawValue, height: ImageSize.square148x148.rawValue)
                        .foregroundColor(Color(UIColor.imagePlaceholderColor!))
                } else {
                    RoundedRectangle(cornerRadius: CustomCornerRadius.corner10.rawValue)
                        .frame(width: ImageSize.square148x148.rawValue, height: ImageSize.square148x148.rawValue)
                        .foregroundColor(Color(UIColor.imagePlaceholderColor!))
                        .overlay {
                            ProgressView()
                        }
                }
            }
            Spacer(minLength: 16)
            Text(vm.model.name)
                .font(Font(UIFont.system22normal))
                .bold()
                .foregroundColor(.white)
            Text(vm.model.status.rawValue)
                .foregroundColor(statusColor(status: vm.model.status))
        }
        .padding()
    }
    
    private var charInfo: some View {
        VStack {
            HStack {
                Text("Info")
                    .font(Font(UIFont.system24normal))
                    .bold()
                Spacer()
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text("Species:")
                        .foregroundColor(Color(UIColor.secondaryTextColor!))
                    Spacer()
                    Text("\(vm.model.species.rawValue)")
                }
                HStack {
                    Text("Type:")
                        .foregroundColor(Color(UIColor.secondaryTextColor!))
                    Spacer()
                    if vm.model.type.isEmpty {
                        Text("None")
                    } else {
                        Text("\(vm.model.type)")
                    }
                    
                }
                HStack {
                    Text("Gender:")
                        .foregroundColor(Color(UIColor.secondaryTextColor!))
                    Spacer()
                    Text("\(vm.model.gender.rawValue)")
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color(UIColor.cardBackground!))
            .cornerRadius(CustomCornerRadius.corner16.rawValue)
        }
        .padding()
    }
    
    private var originInfo: some View {
        VStack(alignment: .leading) {
            Text("Origin")
                .foregroundColor(.white)
                .font(Font(UIFont.system24normal))
                .bold()
            HStack {
                AsyncImage(url: URL(string: vm.model.origin.url)) { phase in
                    if let image = phase.image {
                        image
                            .frame(width: ImageSize.square64x64.rawValue, height: ImageSize.square64x64.rawValue, alignment: .center)
                            .scaledToFit()
                    }  else {
                        Rectangle()
                            .frame(width: ImageSize.square64x64.rawValue, height: ImageSize.square64x64.rawValue)
                            .cornerRadius(CustomCornerRadius.corner10.rawValue)
                            .foregroundColor(Color(UIColor.backgroundColor!))
                            .overlay {
                                Image("planet")
                                    .resizable()
                                    .frame(width: ImageSize.square24x24.rawValue, height: ImageSize.square24x24.rawValue)
                                    .aspectRatio(1/1, contentMode: .fit)
                                    
                                    
                            }
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(vm.origin?.name ?? "")
                        .foregroundColor(.white)
                        .bold()
                    Text(vm.origin?.type ?? "")
                        .foregroundColor(Color(UIColor.greenTextColor!))
                }
                Spacer()
            }
            .padding()
            .background(Color(UIColor.cardBackground!))
            .cornerRadius(CustomCornerRadius.corner16.rawValue)
        }
        .padding()
    }
    
    private var episodesInfo: some View {
        VStack(alignment: .leading) {
            Text("Episodes")
                .foregroundColor(.white)
                .font(Font(UIFont.system24normal))
            VStack {
                ForEach(vm.model.episode, id: \.self) { url in
                    EpisodeCell(url: url)
                }
            }
        }
        .padding(.horizontal)
    }
}




