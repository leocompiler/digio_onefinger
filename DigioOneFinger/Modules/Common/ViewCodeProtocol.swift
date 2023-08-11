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
    func showErrorAlert(title: String, message: String, view: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }))
        view.present(alert, animated: true, completion: nil)
    }
}

class CommonViewController: UIViewController {
    private var loadingView: DotsAnimationView?
    func setLoader(shouldBlock: Bool = true, show: Bool, to view: UIView?) {
           if show {
               showLoader(shouldBlock: shouldBlock, to: view)
           } else {
               hideLoader(to: view)
           }
       }
       func setLoader(show: Bool) {
           setLoader(shouldBlock: true, show: show, to: nil)
       }
       func showLoader() {
           showLoader(shouldBlock: true, to: nil)
       }
       func hideLoader () {
           hideLoader(to: nil)
       }
       func showLoader(shouldBlock: Bool = true, to container: UIView?) {
           view.endEditing(true)
           if loadingView != nil {
               loadingView?.removeFromSuperview()
           }
           let xScreen = UIScreen.main.bounds.size.width*0.5
           let yScreen = UIScreen.main.bounds.size.height*0.5
           let frameSize: CGRect = CGRect(x: xScreen, y: yScreen, width: 10, height: 10)
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
