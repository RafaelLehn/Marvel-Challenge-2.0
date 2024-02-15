//
//  CharacterTableViewCell.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/11/24.
//

import UIKit

protocol CharacterTableViewCellDelegate: AnyObject {
    func isStarButtonTouched(indexPath: Int)
}

class CharacterTableViewCell: UITableViewCell {
    
    static let identifier: String = "CharacterTableViewCell"
    
    weak var delegate: CharacterTableViewCellDelegate?
    
    var item: Int? = nil
    
    lazy var characterName: UILabel = {
        let characterName = UILabel()
        characterName.translatesAutoresizingMaskIntoConstraints = false
        characterName.numberOfLines = 0
        characterName.textAlignment = .center
        
        return characterName
    }()
    
    lazy var parallelogramBackground: ParallelogramView = {
        let parallelogramBackground = ParallelogramView()
        parallelogramBackground.translatesAutoresizingMaskIntoConstraints = false
        
        return parallelogramBackground
    }()
    
    lazy var characterImageView: UIImageView = {
        let characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return characterImageView
    }()
    
    lazy var favoriteButtonView: UIButton = {
        let favoriteButtonView = UIButton()
        favoriteButtonView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButtonView.tintColor = .yellow
        favoriteButtonView.addTarget(self, action: #selector(verifyFavorite), for: .touchUpInside)
        return favoriteButtonView
    }()
    
    @objc private func verifyFavorite(){
        delegate?.isStarButtonTouched(indexPath: self.item!)
    }
    
    func setupCell(characterNameText: String, characterImageUrl: String, starImage: String) {
        characterName.text = characterNameText
        favoriteButtonView.setBackgroundImage(UIImage(systemName: starImage), for: .normal)
        characterImageView.kf.setImage(with: URL(string: characterImageUrl))
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black
        self.contentView.addSubview(characterImageView)
        self.contentView.addSubview(favoriteButtonView)
        self.contentView.addSubview(parallelogramBackground)
        self.parallelogramBackground.addSubview(characterName)
        self.configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            self.characterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            self.characterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  0),
            self.characterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.characterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant:  0),
            
            self.parallelogramBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.parallelogramBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  20),
            self.parallelogramBackground.heightAnchor.constraint(equalToConstant: 60),
            self.parallelogramBackground.widthAnchor.constraint(equalToConstant: 140),
            
            self.characterName.centerYAnchor.constraint(equalTo: self.parallelogramBackground.centerYAnchor),
            self.characterName.trailingAnchor.constraint(equalTo: self.parallelogramBackground.trailingAnchor, constant: -6),
            self.characterName.leadingAnchor.constraint(equalTo: self.parallelogramBackground.leadingAnchor, constant:  6),
            
            self.favoriteButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36),
            self.favoriteButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -16),
            self.favoriteButtonView.heightAnchor.constraint(equalToConstant: 30),
            self.favoriteButtonView.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

