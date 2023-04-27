//
//  ViewCoordinator.swift
//  ReactorKitPractice
//
//  Created by 유지호 on 2023/04/27.
//

import UIKit

class ViewCoordinator: Coordinator {
    
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .normal }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController()
        viewController.reactor = ViewReactor()
        viewController.reactor?.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushSecondViewController() {
        let secondViewController = SecondViewController()
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
    
}
