//
//  ViewController.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/7/24.
//

import UIKit
import Kingfisher

class FavoritsListViewController: UIViewController {
    
    var viewModel : FavoritsListViewModel!
    
    
    private lazy var myView: FavoritsListView = {
        let view = FavoritsListView()
//        view.delegate = self
        return view
    }()
    
    init(viewModel: FavoritsListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myView
//        myView.delegate = self
        myView.tableView.dataSource = self
        myView.tableView.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView.tableView.rowHeight = 300
//        viewModel.delegate = self
        fetchCharacterListStart()
        
    }
    
    func fetchCharacterListStart() {
        viewModel.fetchCoreData()
    }
    
    
}
extension FavoritsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.favorites.isEmpty {
            return 1
        }
        
        return viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let errorCell = tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier, for: indexPath) as? ErrorTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell
        errorCell?.delegate = self
        
        if viewModel.favorites.isEmpty {
            errorCell?.setupCell(titleText: "Your hero request has been failed", hideButton: false)
            return errorCell ?? UITableViewCell()
        }
        
        cell?.setupCell(characterNameText: viewModel.favorites[indexPath.row].name,
                        characterImageUrl: "\(viewModel.favorites[indexPath.row].imageUrl)", starImage: "star.fill")
        
        
        
        return cell ?? UITableViewCell()
    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.coordinator.goToDetail(character: viewModel.characterList[indexPath.row])
//    }
}

extension FavoritsListViewController: ErrorTableViewCellDelegate {
    func didTapTryAgainButton() {
        viewModel.fetchCoreData()
    }
    
    
}

extension FavoritsListViewController: CharacterTableViewCellDelegate {
    func isStarButtonTouched(indexPath: Int) {
        viewModel.deleteFavorite(hero: viewModel.favorites[indexPath])
    }
    
    
}


extension FavoritsListViewController: FavoritsListViewModelProtocol {
    func showRemovedFavorits() {
        fetchCharacterListStart()
    }
    
    
}
