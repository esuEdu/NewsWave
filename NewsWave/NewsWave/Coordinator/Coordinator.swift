//
//  Coordinator.swift
//  NewsWave
//
//  Created by Eduardo on 15/05/24.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var serviceManager: ServiceManager {get set}
    func start()
}
