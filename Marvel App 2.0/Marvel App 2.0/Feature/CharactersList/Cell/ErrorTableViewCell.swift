//
//  ErrorTableViewCell.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/11/24.
//

import UIKit

protocol ErrorTableViewCellDelegate: AnyObject {
    func didTapTryAgainButton()
}

class ErrorTableViewCell: UITableViewCell {
    
    static let identifier: String = "ErrorTableViewCell"
    weak var delegate: ErrorTableViewCellDelegate?
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    lazy var tryAgainButton: UIButton = {
        let tryAgainButton = UIButton()
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        tryAgainButton.setTitle("try again", for: .normal)
        tryAgainButton.backgroundColor = .gray
        tryAgainButton.layer.cornerRadius = 12
        tryAgainButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return tryAgainButton
    }()
    
    func setupCell(titleText: String, hideButton: Bool) {
        titleLabel.text = titleText
        tryAgainButton.isHidden = hideButton
    }
    
    
    @objc
    private func didTapButton() {
        delegate?.didTapTryAgainButton()
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(tryAgainButton)
        self.configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:  20),
            
            self.tryAgainButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.tryAgainButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.tryAgainButton.heightAnchor.constraint(equalToConstant: 60),
            self.tryAgainButton.widthAnchor.constraint(equalToConstant: 140),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

