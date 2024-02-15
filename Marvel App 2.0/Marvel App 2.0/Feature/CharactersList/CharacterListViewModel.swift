//
//  CharacterListViewModel.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/14/24.
//

import Foundation
import Network

protocol CharacterListViewModelProtocol: AnyObject {
    func returnCharacters()
    func returnError()
}

class CharacterListViewModel {
    
    weak var coordinator : AppCoordinator!
    
    var characterList: [Character] = []
    
    var searchCharacterList: [Character] = []
    
    var numberOffset = 0
    
    var delegate: CharacterListViewModelProtocol?
    
    var isSearching = false
    
    var errorValue = false
    
    private let networkService = Network()
        
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchCharacters() {
        networkService.verifyInternet(completion: { internetStatus in
            if internetStatus == .satisfied {
                self.networkService.fetchCharacters(numberOffset: self.numberOffset, completion: { character, characterSelected, error in
                    
                    
                    guard let character = character else {
                        return
                    }

                    guard var characterSelected = characterSelected else {
                        return
                    }

                    if error != nil {
                        self.errorValue = true
                        self.delegate?.returnError()
                        return
                    }
                    
                    self.numberOffset += 100
                    self.characterList.append(contentsOf: characterSelected)
                    self.delegate?.returnCharacters()
                })
            } else {
                
                self.errorValue = true
                self.delegate?.returnError()
            }
        })

        
    }
    
    func goToDetail(character: Character){
        coordinator.goToDetail(character: character)
    }
    
    
}
