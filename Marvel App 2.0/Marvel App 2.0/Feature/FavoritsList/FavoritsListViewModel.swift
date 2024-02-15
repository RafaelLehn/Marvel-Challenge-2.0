//
//  CharacterListViewModel.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/14/24.
//

import Foundation
import Network

protocol FavoritsListViewModelProtocol: AnyObject {
    func showRemovedFavorits()
}

class FavoritsListViewModel {
    
    private let coordinator: AppCoordinator!
    var favorites : [FavoriteHero] = []

    var coreData = DataBaseHelper()
    
    var delegate: FavoritsListViewModelProtocol?
    
        
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    public func goToDetail(hero: Character) {
        coordinator.goToDetail(character: hero)
    }
    
    func deleteFavorite(hero: FavoriteHero) {
        coreData.delete(hero: hero)
        self.delegate?.showRemovedFavorits()
        
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
    
    func goToDetail(character: Character){
        coordinator.goToDetail(character: character)
    }
    
    
}
