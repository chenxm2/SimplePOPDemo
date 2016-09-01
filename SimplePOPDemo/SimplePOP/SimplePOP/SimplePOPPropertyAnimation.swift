//
//  SimplePOPPropertyAnimation.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/27.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation

public class SimplePOPPropertyAnimation: SimplePOPAnimation{
    
    
    override init() {
        let exception = NSException(name: String(SimplePOPPropertyAnimation), reason: "Attempting to instantiate an abstract class. Use a concrete subclass instead", userInfo: nil);
        exception .raise()
        super.init()
    }
    
    override init(state: SimplePOPAnimationState) {
        super.init(state:state)
    }
    
    var animationState : SimplePOPPropertyAnimationState? {
        get {
            return _animationState as? SimplePOPPropertyAnimationState
        }
    }
    
    var animationproperty : SimplePOPAnimatableProperty? {
        set {
            self.animationState?.property = newValue;
        }
        get {
            return self.animationState?.property
        }
    }
    
    
    public var formValue : CGPoint? {
        set {
            self.animationState?.fromValue = newValue
        }
        get {
            return self.animationState?.fromValue
        }
    }
    public var toValue : CGPoint? {
        set {
            self.animationState?.toValue = newValue
        }
        get {
            return self.animationState?.toValue
        }
        
    }
}