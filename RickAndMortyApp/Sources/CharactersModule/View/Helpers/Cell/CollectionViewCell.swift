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
    
    
    private lazy var mainPlate: UIView = {
       let view = UIView()
        view.backgroundColor = .cardBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = CustomCornerRadius.corner16.rawValue
        
        return view
    }()
    private lazy var nameLabel: UILabel = {
        let lab = UILabel()
        lab.font = .system18normal
        lab.textColor = .white
        lab.textAlignment = .center
        lab.numberOfLines = 2
        lab.setContentHuggingPriority(.required, for: .vertical)
        lab.setContentHuggingPriority(.required, for: .horizontal)
        return lab
    }()
    
    private lazy var charImage: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = CustomCornerRadius.corner10.rawValue
        iv.clipsToBounds = true
        iv.backgroundColor = .imagePlaceholderColor
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonSetup() {
        setupHierarchy()
        setupLayer()
    }
    private func setupHierarchy() {
        contentView.addSubview(mainPlate)
        mainPlate.addSubview(nameLabel)
        mainPlate.addSubview(charImage)
    }
    
    func setupCell(model: CharacterInfo) {
        self.nameLabel.text = model.name
        self.charImage.imageFromServerURL(model.image, placeHolder: UIImage(named: "image_placeholder"))
    }
    
    private func setupLayer() {
        
        mainPlate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainPlate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainPlate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainPlate.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainPlate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        charImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            charImage.leadingAnchor.constraint(equalTo: mainPlate.leadingAnchor, constant: CustomPaddings.padding8.rawValue),
            charImage.trailingAnchor.constraint(equalTo: mainPlate.trailingAnchor, constant: -CustomPaddings.padding8.rawValue),
            charImage.topAnchor.constraint(equalTo: mainPlate.topAnchor, constant: CustomPaddings.padding8.rawValue),
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: charImage.bottomAnchor, constant: CustomPaddings.padding16.rawValue),
            nameLabel.leadingAnchor.constraint(equalTo: charImage.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: charImage.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: mainPlate.bottomAnchor, constant: -CustomPaddings.padding16.rawValue)
        ])
    }
}
