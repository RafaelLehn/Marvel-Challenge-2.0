//
//  View.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/7/24.
//

import UIKit

protocol ViewDelegate: AnyObject {
    func didTapButton()
}

class CharacterListView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.identifier)
        tableView.backgroundColor = .black
        return tableView
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.color = .white
        loadingView.startAnimating()
        return loadingView
    }()
    
    
    lazy var searchTextField: UISearchBar = {
        let searchTextField =  UISearchBar(frame: .zero)
        searchTextField.placeholder = "Search your hero"
        searchTextField.barStyle = .black
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.autocorrectionType = UITextAutocorrectionType.no
        searchTextField.keyboardType = UIKeyboardType.default
        searchTextField.returnKeyType = UIReturnKeyType.done
        return searchTextField
    }()
    
    lazy var favoritesButton: UIButton = {
        let favoritesButton = UIButton()
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.setTitle("show favorites", for: .normal)
        
        favoritesButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return favoritesButton
    }()
    
    weak var delegate: ViewDelegate?
    
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

extension CharacterListView: ViewCode {
    func addSubviews() {
        addSubview(searchTextField)
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(favoritesButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            self.searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.favoritesButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            self.favoritesButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.favoritesButton.heightAnchor.constraint(equalToConstant: 40),
            self.favoritesButton.widthAnchor.constraint(equalToConstant: 120),
            
            
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
