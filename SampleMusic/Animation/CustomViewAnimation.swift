//
//  CustomViewAnimation.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 17.12.21.
//

import UIKit

enum CustomViewAnimation {
    case fadeIn(duration: TimeInterval, delayFactor: TimeInterval)
    
    func getAnimation() -> ViewAnimation {
        switch self {
        case .fadeIn(duration: let duration, delayFactor: let delay):
            return ViewAnimationFactory.makeFadeAnimation(duration: duration, delayFactor: delay)
        }
    }
}
