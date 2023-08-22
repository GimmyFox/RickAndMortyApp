//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 17.08.2023.
//

import UIKit
import SwiftUI

class CharactersViewController: UIViewController {
    
    private let vm = CharactersViewModel()
    private let customNavigationBar = CustomNavigationBar()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.backgroundColor = .backgroundColor
        col.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
        col.translatesAutoresizingMaskIntoConstraints = false
        return col
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .backgroundColor
        
        setupLayout()
        setupHierarchy()
        setupDelegates()
    }

    func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension CharactersViewController {
    func setupLayout() {
        view.addSubview(customNavigationBar)
        view.addSubview(collectionView)
        collectionView.addSubview(activityIndicator)
    }
    
    func setupHierarchy() {
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: 25),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = vm.mainModel else {return}
        let vc = UIHostingController(rootView: CharacterDescriptionView(characterInfo: model.results[indexPath.row], action: {
            self.navigationController?.popViewController(animated: true)
        }))
        vc.navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.mainModel?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        if let model = vm.mainModel {
            cell.charInfo = model.results[indexPath.row]
            cell.setupCell()
        }
        return cell
    }
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width * 0.5) - CustomPaddings.padding16.rawValue * 2, height: view.frame.height * 0.25)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: CustomPaddings.padding16.rawValue, bottom: 0, right: CustomPaddings.padding16.rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CustomPaddings.padding16.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CustomPaddings.padding16.rawValue
    }
}
extension CharactersViewController: CharactersViewModelDelegate {
    func completeFetching() {
        collectionView.reloadData()
    }
    func handleActivityIndicator(isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}



