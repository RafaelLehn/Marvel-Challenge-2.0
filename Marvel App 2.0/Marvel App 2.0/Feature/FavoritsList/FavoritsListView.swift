//
//  View.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/7/24.
//

import UIKit

protocol FavoritsListViewDelegate: AnyObject {
    func didTapButton()
}

class FavoritsListView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    weak var delegate: FavoritsListViewDelegate?
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    private func didTapButton() {
        delegate?.didTapButton()
    }
}

extension FavoritsListView: ViewCode {
    func addSubviews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
    }
    
    func setupStyle() {
        backgroundColor = .black
    }
}
