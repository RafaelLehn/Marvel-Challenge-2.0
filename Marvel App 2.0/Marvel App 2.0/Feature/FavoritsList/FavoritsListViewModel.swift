//
//  CharacterListViewModel.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/14/24.
//

import Foundation
import Network

protocol FavoritsListViewModelProtocol: AnyObject {
    func returnCharacters()
    func returnError()
}

class FavoritsListViewModel {
    
    weak var coordinator : AppCoordinator!
    
    var characterList: [Character] = []
    
    var delegate: CharacterListViewModelProtocol?
    
    var errorValue = false
        
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchCharacters() {
        
    }
    
    func goToDetail(character: Character){
        coordinator.goToDetail(character: character)
    }
    
    
}
