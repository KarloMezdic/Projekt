import UIKit
import Foundation

protocol AppRouterProtocol {
    func setStartScreen(in window: UIWindow?)
    func navigateToHomeScreen()
}

class AppRouter: AppRouterProtocol {
    
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setStartScreen(in window: UIWindow?) {
        let vc = LoginViewController(router:self)
        
        navigationController.setViewControllers([vc], animated: false)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateToHomeScreen() {
        let homeViewController = HomeViewController()
        navigationController.setViewControllers([homeViewController], animated: true)
    }
}
