//
//  MainCoordinator.swift
//  NewsWave
//
//  Created by Eduardo on 15/05/24.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    
    var serviceManager: ServiceManager
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, serviceManager: ServiceManager) {
        self.navigationController = navigationController
        self.serviceManager = serviceManager
    }

    
    func start() {
        let view = ViewController()
        navigationController.pushViewController(view, animated: true)
    }
    
    
}
