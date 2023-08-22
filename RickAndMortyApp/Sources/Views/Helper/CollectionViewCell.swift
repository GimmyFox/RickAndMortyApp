//
//  CollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 21.08.2023.
//

import Foundation
import UIKit


class CollectionViewCell: UICollectionViewCell {
    static let id = "CollectionViewID"
    
    var charInfo: CharacterInfo!
    
    private lazy var mainPlate: UIView = {
       let view = UIView()
        view.backgroundColor = .cardBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = CustomCornerRadius.corner16.rawValue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let lab = UILabel()
        lab.font = .system18normal
        lab.textColor = .white
        lab.textAlignment = .center
        lab.numberOfLines = 2
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    private lazy var charImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = CustomCornerRadius.corner10.rawValue
        iv.clipsToBounds = true
        iv.backgroundColor = .imagePlaceholderColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayer()
    }
    
    private func setupHierarchy() {
        self.addSubview(mainPlate)
        mainPlate.addSubview(nameLabel)
        mainPlate.addSubview(charImage)
    }
    
    func setupCell() {
        self.nameLabel.text = charInfo.name
        self.charImage.imageFromServerURL(charInfo.image, placeHolder: nil)
    }
    
    private func setupLayer() {
        NSLayoutConstraint.activate([
            mainPlate.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainPlate.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainPlate.topAnchor.constraint(equalTo: self.topAnchor),
            mainPlate.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            charImage.leadingAnchor.constraint(equalTo: mainPlate.leadingAnchor, constant: CustomPaddings.padding8.rawValue),
            charImage.trailingAnchor.constraint(equalTo: mainPlate.trailingAnchor, constant: -CustomPaddings.padding8.rawValue),
            charImage.topAnchor.constraint(equalTo: mainPlate.topAnchor, constant: CustomPaddings.padding8.rawValue),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: charImage.bottomAnchor, constant: CustomPaddings.padding16.rawValue),
            nameLabel.leadingAnchor.constraint(equalTo: charImage.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: charImage.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: mainPlate.bottomAnchor, constant: -CustomPaddings.padding16.rawValue)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
