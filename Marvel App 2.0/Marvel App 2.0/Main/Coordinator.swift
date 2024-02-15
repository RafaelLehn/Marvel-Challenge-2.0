//
//  Coordinator.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/14/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
