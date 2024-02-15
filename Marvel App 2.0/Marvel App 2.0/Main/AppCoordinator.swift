//
//  AppCoordinator.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/14/24.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    func start() {
        goToHome()
    }
    
    func goToHome(){
        let homeViewModel = CharacterListViewModel.init(coordinator: self)
        let homeController = ViewController.init(viewModel: homeViewModel)
        navigationController.pushViewController(homeController, animated: true)
    }
    
    func goToDetail(character: Character){
        let characterDetailViewController = CharacterDetailViewController.init()
        let characterDetailViewModel = CharacterDetailViewModel.init(with: character)
        characterDetailViewModel.coordinator = self
        characterDetailViewController.viewModel = characterDetailViewModel
        navigationController.pushViewController(characterDetailViewController, animated: true)
    }
    
    func goToFavorits(){
        let favoritsListViewModel = FavoritsListViewModel.init(coordinator: self)
        let favoritsListViewController = FavoritsListViewController.init(viewModel: favoritsListViewModel)
        navigationController.pushViewController(favoritsListViewController, animated: true)
    }
}

