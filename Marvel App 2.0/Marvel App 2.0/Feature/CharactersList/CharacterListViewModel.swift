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
    
    var favorites : [FavoriteHero] = []
    
    var numberOffset = 0
    
    var delegate: CharacterListViewModelProtocol?
    
    var isSearching = false
    
    var errorValue = false
    
    private let networkService = Network()
    
    var coreData = DataBaseHelper()
        
    
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
    
    func buttonStarTappedAt(HeroIndex: Int){
       let toFavorite = characterList[HeroIndex]
        if checkFavorite(movieName: toFavorite.name){
            let favMovie = favorites.filter { item in item.name.contains(toFavorite.name) }
            deleteFavorite(hero: favMovie[0])
            fetchCoreData()
    
        } else {
            saveFavorite(hero: toFavorite)
            fetchCoreData()
        }
    }
    
    func checkFavorite(movieName: String) -> Bool{return favorites.contains(where: {$0.name == movieName})}
    
    func deleteFavorite(hero: FavoriteHero) { coreData.delete(hero: hero) }
    
    func saveFavorite(hero: Character){
        
        let favoriteHero: HeroToCoreData = HeroToCoreData(
            
            name: hero.name, imageURL: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension.rawValue)", summary: hero.description
        )
        coreData.save(hero: favoriteHero)
    }
    
    func fetchCoreData(){
        coreData.requestFavorites { (favoritesMoviesCoreData:Result<[FavoriteHero], Error>) in
            switch favoritesMoviesCoreData {
            case.success(let favoritesMoviesCoreData):
                self.favorites = favoritesMoviesCoreData
            case.failure(let error):
                print(error)
            }
        }
    }
    
}
