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

class CommonViewController: UIViewController {
    
    private var loadingView: DotsAnimationView?
   
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        ConsoleLog.normal(message: "traitCollectionDidChange")
        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if traitCollection.userInterfaceStyle == .dark {
                    //Dark
                }
                else {
                    //Light
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
     
    
    func setLoader(shouldBlock: Bool = true, show: Bool, to view: UIView?) {
           if show {
               showLoader(shouldBlock: shouldBlock,to: view)
           } else {
               hideLoader(to: view)
           }
       }
       
       func setLoader(show: Bool) {
           setLoader(shouldBlock: true,show: show, to: nil)
       }
       
       func showLoader() {
           showLoader(shouldBlock: true ,to: nil)
       }
       
       func hideLoader () {
           hideLoader(to: nil)
       }
       
       func showLoader(shouldBlock: Bool = true,to container: UIView?) {
       
            
           view.endEditing(true)
           
           let bounds = shouldBlock ? UIScreen.main.bounds : view.bounds
           let frame = container?.frame ?? CGRect(
               x: 0,
               y: 0,
               width: bounds.size.width,
               height: bounds.size.height
           )
           if loadingView != nil {
               loadingView?.removeFromSuperview()
           }
           let x = UIScreen.main.bounds.size.width*0.5
           let y = UIScreen.main.bounds.size.height*0.5
           let frameSize: CGRect = CGRect(x: x,y: y,width: 10,height: 10)
           loadingView = DotsAnimationView(frame: frameSize, dotSize: .init(width: 10, height: 10), dotColor: .black)
           view.alpha = 0.5
           if shouldBlock && navigationController != nil {
               navigationController?.view.addSubview(loadingView!)
               navigationController?.view.isUserInteractionEnabled = false
           } else {
               view.addSubview(loadingView!)
               view.isUserInteractionEnabled = false
           }
           if let subView = container {
               loadingView?.snp.makeConstraints({ make in
                   make.edges.equalTo(subView.snp.edges)
               })
           }
           
       }
       
       func hideLoader (to container: UIView?) {
         
           guard let _ = loadingView else { return }
           self.onCloseLoader()
           
       }
       
       private func onCloseLoader() {
           
           loadingView?.removeFromSuperview()
           loadingView = nil
           view.isUserInteractionEnabled = true
           view.alpha = 1
       }
    
}
