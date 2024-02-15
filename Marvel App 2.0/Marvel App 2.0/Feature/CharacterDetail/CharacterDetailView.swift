//
//  CharacterDetailView.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/14/24.
//

import UIKit

protocol CharacterDetailViewDelegate: AnyObject {
    func didTapButton()
}

class CharacterDetailView: UIView {
    
    lazy var characterNameLabel: UILabel = {
        let characterName = UILabel()
        characterName.translatesAutoresizingMaskIntoConstraints = false
        characterName.numberOfLines = 0
        characterName.textColor = .white
        return characterName
    }()
    
    lazy var characterDescriptionLabel: UILabel = {
        let characterName = UILabel()
        characterName.translatesAutoresizingMaskIntoConstraints = false
        characterName.numberOfLines = 0
        characterName.textColor = .white
        
        return characterName
    }()
    
    lazy var characterImageView: UIImageView = {
        let characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return characterImageView
    }()
    
    lazy var shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        
        shareButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return shareButton
    }()
    
    
    lazy var favoriteButtonView: UIButton = {
        let favoriteButtonView = UIButton()
        favoriteButtonView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButtonView.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        favoriteButtonView.tintColor = .yellow
        return favoriteButtonView
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.color = .white
        loadingView.startAnimating()
        return loadingView
    }()
    
    weak var delegate: ViewDelegate?
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCharacterSelected(characterName: String, characterImage: UIImage, characterDesc: String) {
        characterNameLabel.text = characterName
        characterImageView.image = characterImage
        characterDescriptionLabel.text = characterDesc
        loadingView.stopAnimating()
    }
    
    @objc
    private func didTapButton() {
        delegate?.didTapButton()
    }
}

extension CharacterDetailView: ViewCode {
    func addSubviews() {
        addSubview(characterImageView)
        addSubview(loadingView)
        addSubview(favoriteButtonView)
        addSubview(characterNameLabel)
        addSubview(characterDescriptionLabel)
        addSubview(shareButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.characterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            self.characterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.characterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.characterImageView.heightAnchor.constraint(equalToConstant: 300),
            
            self.favoriteButtonView.bottomAnchor.constraint(equalTo: self.characterImageView.bottomAnchor, constant: -36),
            self.favoriteButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -16),
            self.favoriteButtonView.heightAnchor.constraint(equalToConstant: 30),
            self.favoriteButtonView.widthAnchor.constraint(equalToConstant: 30),
            
            
            
            self.characterNameLabel.topAnchor.constraint(equalTo: self.characterImageView.bottomAnchor, constant: 16),
            self.characterNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.characterNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            
            self.characterDescriptionLabel.topAnchor.constraint(equalTo: self.characterNameLabel.bottomAnchor, constant: 16),
            self.characterDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.characterDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            self.shareButton.topAnchor.constraint(equalTo: self.characterDescriptionLabel.bottomAnchor, constant: 16),
            self.shareButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.shareButton.heightAnchor.constraint(equalToConstant: 60),
            self.shareButton.widthAnchor.constraint(equalToConstant: 60),
            
            
            self.loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.loadingView.heightAnchor.constraint(equalToConstant: 120),
            self.loadingView.widthAnchor.constraint(equalToConstant: 120),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .black
    }
}
