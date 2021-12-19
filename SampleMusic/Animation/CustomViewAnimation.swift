//
//  CustomViewAnimation.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 17.12.21.
//

import UIKit

enum CustomViewAnimation {
    case fadeIn(duration: TimeInterval, delayFactor: TimeInterval)
    case makeBiggerLower(duration: TimeInterval, delayFactor: TimeInterval, springWithDamb: TimeInterval, springVelocity: TimeInterval)
    
    func getAnimation() -> ViewAnimation {
        switch self {
        case .fadeIn(duration: let duration, delayFactor: let delay):
            return ViewAnimationFactory.makeFadeAnimation(duration: duration, delayFactor: delay)
        case.makeBiggerLower(duration: let duration, delayFactor: let delay, springWithDamb: let springDamb, springVelocity: let springVelocity):
            return ViewAnimationFactory.makeBiggerLowerAnimation(duration: duration, delayFactor: delay, springWithDamb: springDamb, springVelocity: springVelocity)
        }
    }
}
