//
//  ViewCodeProtocol.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 04/08/23.
//


import UIKit

public protocol ViewCodeProtocol {  associatedtype CustomView: UIView }

extension ViewCodeProtocol where Self: UIViewController {

    public var customView: CustomView {
        guard let customView = view as? CustomView else {
            let error = "Get viewCode bug! View probable be \(CustomView.self), not  \(type(of: view))."
            fatalError(error)
        }
        return customView
    }
    
    func showErrorAlert(title: String,message: String, view: UIViewController){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                break;
                case .cancel:
                print("cancel")
                break;
                case .destructive:
                print("destructive")
                break;
             default:
                fatalError("Error - touch value return")
                break;
            }
        }))
        view.present(alert, animated: true, completion: nil)
    }
}

