//
//  SimplePOPAnimation.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/25.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation


public class SimplePOPAnimation: NSObject {
    
    var _animationState : SimplePOPAnimationState
    override init() {
        let exception = NSException(name: String(SimplePOPAnimation), reason: "Attempting to instantiate an abstract class. Use a concrete subclass instead", userInfo: nil);
        exception .raise();
        //了编译通过
        _animationState = SimplePOPAnimationState()
        
    }
    
    init(state:SimplePOPAnimationState){
        _animationState = state;
    }
}


//MARK:
extension NSObject {
    public func simplePOP_addAnimation(let aninamtion:SimplePOPAnimation , withKey key:String) {
        SimplePOPAnimator.sharedInstance.addAnimation(aninamtion, forObject: self, withKey: key)
    }
    
    public func simplePOP_removeAnimationWithKey(key:String){
    }
}
