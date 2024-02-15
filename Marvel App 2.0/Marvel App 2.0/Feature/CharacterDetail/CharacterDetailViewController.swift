//
//  CharacterDetailViewController.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/14/24.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {
    
    var viewModel : CharacterDetailViewModel!
    
    private lazy var myView: CharacterDetailView = {
        let view = CharacterDetailView()
        var characterImage = UIImage()
        let resource = ImageResource(downloadURL: URL(string: "\(viewModel.character!.thumbnail.path).\(viewModel.character!.thumbnail.thumbnailExtension.rawValue)")!)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
                case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
                characterImage = value.image
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        view.setupCharacterSelected(characterName: viewModel.character?.name ?? "", characterImage: characterImage, characterDesc: viewModel.character?.description ?? "")
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        self.view = myView
        
                myView.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CharacterDetailViewController: ViewDelegate {
    func didTapButton() {
        
        let image = myView.characterImageView.image
        
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
