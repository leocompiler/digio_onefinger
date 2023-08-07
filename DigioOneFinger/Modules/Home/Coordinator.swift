//
//  Coordinator.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 07/08/23.
//

import Foundation
import UIKit

enum CoordinatorSteps: Int {
 
    case home = 0
    case itemDetail = 1

}

class Coordinator {
    
    private let nextStep: CoordinatorSteps?
       
       init(nextStep: CoordinatorSteps? = nil) {
           self.nextStep = nextStep
       }
    func starts(    on nav: UINavigationController?,
                    animated: Bool = false,
                    item: ItemModel? = nil) {
        
        switch nextStep {
        case .home:
            nav?.pushViewController(HomeViewController(), animated: animated)
        case .itemDetail:
            nav?.pushViewController(ItemDetailController(item), animated: animated)
        default: break
        }
    }

    func getViewController() -> UIViewController {

        switch nextStep {
            case .home:
                return HomeViewController()
            case .itemDetail:
                return ItemDetailController()
            default: return HomeViewController()
        }

    }
}
