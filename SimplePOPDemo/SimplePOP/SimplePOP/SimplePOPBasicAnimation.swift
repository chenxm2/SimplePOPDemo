//
//  SimplePOPBasicAnimation.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/27.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation
public class SimplePOPBasicAnimation: SimplePOPPropertyAnimation {

    
    public static func animationWithPropertyNamed(name:String)-> SimplePOPBasicAnimation{
        let basicAnimation = self.animation();
        basicAnimation.animationproperty = SimplePOPAnimatableProperty .propertyWithName(name)
        return basicAnimation
    }
    
    static func animation()->SimplePOPBasicAnimation {
        let animationState = SimplePOPBasicAnimationState()
        let basicAnimation = SimplePOPBasicAnimation(state:animationState);
        
        return basicAnimation
    }
    
   override var animationState : SimplePOPBasicAnimationState? {
        get {
            return _animationState as? SimplePOPBasicAnimationState
        }
    }

    
    public var duration : NSTimeInterval? {
        set{
            self.animationState?.duration = newValue!
        }
        get {
            return self.animationState?.duration
        }
    }
    
    public var timingFunctionType : SimplePOPTimingFunctionType! {
        set {
            self.animationState?.timingFunctionType = newValue
        }
        get {
            return self.animationState?.timingFunctionType
        }
    }
}