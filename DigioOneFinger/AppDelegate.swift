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
    var orientationLock = UIInterfaceOrientationMask.portrait
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        let coordinator = Coordinator(nextStep: CoordinatorSteps.home)
        let mainViewController = coordinator.getViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.setViewControllers([mainViewController], animated: false)
        navigationController.navigationBar.frame = .zero
        navigationController.navigationBar.tintColor = .gray
        navigationController.navigationBar.isTranslucent   = true
        navigationController.navigationBar.barTintColor    = .white
        navigationController.navigationBar.backgroundColor = .clear
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.transform = CGAffineTransform(translationX: 0, y: 0)

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    func application(   _ application: UIApplication,
                        supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
}
