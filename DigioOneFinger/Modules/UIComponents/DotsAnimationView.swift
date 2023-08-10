//
//  LoadingView.swift
//  DigioOneFinger
//
//  Created by LEONARDO A SILVEIRA on 09/08/23.
//
import UIKit
class DotsAnimationView: UIView {
    
    // MARK: - Subviews
    
    private lazy var dot1View = UIView()
    private lazy var dot2View = UIView()
    private lazy var dot3View = UIView()
    
    // MARK: - Properties
    
    private var dotSize: CGSize
    private var dotColor: UIColor
    
    
    // MARK: - Initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame: CGRect = .zero, dotSize: CGSize, dotColor: UIColor){
        self.dotSize = dotSize
        self.dotColor = dotColor
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(dot1View)
        addSubview(dot2View)
        addSubview(dot3View)
        
        [dot1View, dot2View, dot3View].forEach {
            $0.backgroundColor = dotColor
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: dotSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: dotSize.height).isActive = true
            $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            $0.clipsToBounds = true
            $0.layer.cornerRadius = dotSize.width / 2
        }
        
        dot2View.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dot1View.rightAnchor.constraint(equalTo: dot2View.leftAnchor, constant: -15).isActive = true
        dot3View.leftAnchor.constraint(equalTo: dot2View.rightAnchor, constant: 15).isActive = true
        animationView(dot1View)
        animationView(dot2View)
        animationView(dot3View)
    }
    private func animationView(_ view: UIView){
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        view.layer.add(pulseAnimation, forKey: nil)
    }
  
}
 
