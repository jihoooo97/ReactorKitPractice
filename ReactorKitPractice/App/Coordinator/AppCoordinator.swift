//
//  AppCoordinator.swift
//  Lotty
//
//  Created by 유지호 on 2023/04/21.
//

import UIKit

protocol AppCoordinator: Coordinator {
    func showDefaultFlow()
}

final class DefaultAppCoordinator: AppCoordinator {
    
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .app }
    
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        showDefaultFlow()
    }
    
    func showDefaultFlow() {
        let viewCoordinator = ViewCoordinator(navigationController)
        viewCoordinator.finishDelegate = self
        viewCoordinator.start()
        childCoordinators.append(viewCoordinator)
    }
    
}


extension DefaultAppCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter {
            $0.type != childCoordinator.type
        }
        
        self.navigationController.view.backgroundColor = .white
        self.navigationController.viewControllers.removeAll()
        
        switch childCoordinator.type {
        case .normal:
            showDefaultFlow()
        default:
            break
        }
    }
    
}
