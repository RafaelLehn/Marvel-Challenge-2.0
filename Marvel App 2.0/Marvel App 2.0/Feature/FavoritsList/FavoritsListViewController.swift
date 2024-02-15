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
//        myView.tableView.dataSource = self
//        myView.tableView.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView.tableView.rowHeight = 300
//        viewModel.delegate = self
        fetchCharacterListStart()
        
    }
    
    func fetchCharacterListStart() {
        self.viewModel.errorValue = false
        self.myView.tableView.isHidden = true
        viewModel.fetchCharacters()
    }
    
    func fetchCharacterListEnd() {
        DispatchQueue.main.async {
            self.myView.tableView.reloadData()
            self.myView.tableView.isHidden = false
        }
    }
    
    
}
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if viewModel.errorValue {
//            return 1
//        }
//        
//        if viewModel.isSearching {
//            if viewModel.searchCharacterList.count > 0 {
//                return viewModel.searchCharacterList.count
//            } else {
//                return 1
//            }
//        }
//        
//        return viewModel.characterList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        
//        let errorCell = tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier, for: indexPath) as? ErrorTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell
//        errorCell?.delegate = self
//        
//        if viewModel.errorValue {
//            errorCell?.setupCell(titleText: "Your hero request has been failed", hideButton: false)
//            return errorCell ?? UITableViewCell()
//        }
//        
//        if viewModel.isSearching {
//            if viewModel.searchCharacterList.count > 0 {
//                cell?.characterName.text = viewModel.searchCharacterList[indexPath.row].name
//                cell?.characterImageView.kf.setImage(with: URL(string: "\(viewModel.searchCharacterList[indexPath.row].thumbnail.path).\(viewModel.searchCharacterList[indexPath.row].thumbnail.thumbnailExtension.rawValue)"))
//            } else {
//                errorCell?.setupCell(titleText: "No hero with this name was found", hideButton: true)
//                return errorCell ?? UITableViewCell()
//            }
//        } else {
//            
//            cell?.characterName.text = viewModel.characterList[indexPath.row].name
//            cell?.characterImageView.kf.setImage(with: URL(string: "\(viewModel.characterList[indexPath.row].thumbnail.path).\(viewModel.characterList[indexPath.row].thumbnail.thumbnailExtension.rawValue)"))
//        }
//        
//        return cell ?? UITableViewCell()
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.coordinator.goToDetail(character: viewModel.characterList[indexPath.row])
//    }
//}
//
//extension ViewController: ErrorTableViewCellDelegate {
//    func didTapTryAgainButton() {
//        fetchCharacterListStart()
//    }
//}
//
//
