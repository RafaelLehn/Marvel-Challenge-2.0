//
//  ViewController.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/7/24.
//


import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    var viewModel : CharacterListViewModel!
    
    
    private lazy var myView: CharacterListView = {
        let view = CharacterListView()
        view.delegate = self
        return view
    }()
    
    init(viewModel: CharacterListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = myView
        myView.delegate = self
        myView.tableView.dataSource = self
        myView.tableView.delegate = self
        myView.searchTextField.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView.tableView.rowHeight = 300
        viewModel.delegate = self
        fetchCharacterListStart()
        
    }
    
    func fetchCharacterListStart() {
        self.viewModel.errorValue = false
        self.myView.tableView.isHidden = true
        self.myView.loadingView.startAnimating()
        self.myView.loadingView.isHidden = false
        viewModel.fetchCharacters()
    }
    
    func fetchCharacterListEnd() {
        DispatchQueue.main.async {
            self.myView.tableView.reloadData()
            self.myView.tableView.isHidden = false
            self.myView.loadingView.stopAnimating()
        }
    }
    
    
}

extension ViewController: CharacterListViewModelProtocol {
    func returnCharacters() {
        fetchCharacterListEnd()
    }
    
    func returnError() {
        fetchCharacterListEnd()
    }
    
    
}

extension ViewController: ViewDelegate {
    func didTapButton() {
        viewModel.coordinator.goToFavorits()
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if viewModel.isSearching == false {
            viewModel.isSearching = true
            viewModel.searchCharacterList = viewModel.characterList
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.myView.searchTextField.text = ""
        self.viewModel.searchCharacterList = []
        viewModel.isSearching = false
        self.myView.searchTextField.showsCancelButton = false
        self.myView.searchTextField.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        self.myView.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text! == ""  {
            self.viewModel.searchCharacterList = viewModel.characterList
            self.myView.tableView.reloadData()
        } else {
            self.viewModel.searchCharacterList = viewModel.characterList.filter({ (character) -> Bool in
                return (character.name.localizedCaseInsensitiveContains(String(searchBar.text!)))
            })
            self.myView.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.errorValue {
            return 1
        }
        
        if viewModel.isSearching {
            if viewModel.searchCharacterList.count > 0 {
                return viewModel.searchCharacterList.count
            } else {
                return 1
            }
        }
        
        return viewModel.characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let errorCell = tableView.dequeueReusableCell(withIdentifier: ErrorTableViewCell.identifier, for: indexPath) as? ErrorTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell
        errorCell?.delegate = self
        
        if viewModel.errorValue {
            errorCell?.setupCell(titleText: "Your hero request has been failed", hideButton: false)
            return errorCell ?? UITableViewCell()
        }
        
        if viewModel.isSearching {
            if viewModel.searchCharacterList.count > 0 {
                cell?.characterName.text = viewModel.searchCharacterList[indexPath.row].name
                cell?.characterImageView.kf.setImage(with: URL(string: "\(viewModel.searchCharacterList[indexPath.row].thumbnail.path).\(viewModel.searchCharacterList[indexPath.row].thumbnail.thumbnailExtension.rawValue)"))
            } else {
                errorCell?.setupCell(titleText: "No hero with this name was found", hideButton: true)
                return errorCell ?? UITableViewCell()
            }
        } else {
            
            cell?.characterName.text = viewModel.characterList[indexPath.row].name
            cell?.characterImageView.kf.setImage(with: URL(string: "\(viewModel.characterList[indexPath.row].thumbnail.path).\(viewModel.characterList[indexPath.row].thumbnail.thumbnailExtension.rawValue)"))
        }
        
        
        
        if tableView.isLast(for: indexPath) && !viewModel.isSearching {
            fetchCharacterListStart()
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.coordinator.goToDetail(character: viewModel.characterList[indexPath.row])
    }
}

extension ViewController: ErrorTableViewCellDelegate {
    func didTapTryAgainButton() {
        fetchCharacterListStart()
    }
}

extension UITableView {
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
}


