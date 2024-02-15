//
//  CharacterDetailViewModel.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/14/24.
//
protocol CharacterDetailViewModelProtocol: AnyObject {
    func returnCharacters()
    func returnError()
}

class CharacterDetailViewModel {
    
    weak var coordinator : AppCoordinator!
    
    var isSearching = false
        
    var character: Character?
    
    init(with character: Character) {
        self.character = character
    }
    
    
    
    
}
