//
//  AnimatedView.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 17.12.21.
//

import UIKit

typealias ViewAnimation = (UIView) -> Void


final class AnimatedView {
    private let animation: ViewAnimation
    
    init(animation: @escaping ViewAnimation) {
        self.animation = animation
    }
    
    func animate(view: UIView) {
        animation(view)
    }
}

enum ViewAnimationFactory {
    static func makeFadeAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> ViewAnimation {
        return { view in
            view.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor) {
                    view.alpha = 1
                }
        }
    }
}
