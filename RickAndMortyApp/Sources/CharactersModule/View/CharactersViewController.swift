//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 17.08.2023.
//

import UIKit
import SwiftUI


protocol CharactersViewProtocol {
    func success()
    func onFailure(error: ApiClientError)
    func startActivityIndicator()
    func stopActivityIndicator()
}

final class CharactersViewController: UIViewController {
    
    var presenter: CharactersPresenterProtocol?
    private lazy var customNavigationBar = CustomNavigationBar()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let col = UICollectionView(frame: .zero, collectionViewLayout: layout)
        col.backgroundColor = .backgroundColor
        col.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
        return col
    }()
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupHierarchy()
        setupDelegates()
        setupView()
        presenter?.requestCharacters()
    }

    private func setupDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension CharactersViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = presenter?.mainModel else {
            return
            
        }
        let vc = Builder().createDescriptionViewController(model: model.results[indexPath.row]) {
            self.navigationController?.popViewController(animated: true)
        }
        vc.navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.mainModel?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.id, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        if let model = presenter?.mainModel {
            cell.setupCell(model: model.results[indexPath.row])
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

extension CharactersViewController: CharactersViewProtocol {
    
    func success() {
        collectionView.reloadData()
    }
    
    func onFailure(error: ApiClientError) {
        guard presentedViewController == nil else {
            return
        }
        
        let alert = UIAlertController(title: "Error", message: "got this issue: \(error.localizedDescription)", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "cancel", style: .cancel)
        let refreshButton = UIAlertAction(title: "refresh", style: .default) { [weak self] _ in
            self?.presenter?.requestCharacters()
        }
        alert.addAction(refreshButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    func startActivityIndicator() {
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
}

private extension CharactersViewController {
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
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: 25),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func setupView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .backgroundColor
    }
}

