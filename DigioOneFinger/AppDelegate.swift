//
//  AppDelegate.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 01/08/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds);

        let coordinator = Coordinator(nextStep: CoordinatorSteps.home)
        let vc = coordinator.getViewController()
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.setViewControllers([vc], animated: false)
        navigationController.navigationBar.frame = .zero
        navigationController.navigationBar.tintColor = .gray
        navigationController.navigationBar.isTranslucent   = true
        navigationController.navigationBar.barTintColor    = .white
        navigationController.navigationBar.backgroundColor = .clear
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.transform = CGAffineTransform(translationX: 0, y: -20)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
