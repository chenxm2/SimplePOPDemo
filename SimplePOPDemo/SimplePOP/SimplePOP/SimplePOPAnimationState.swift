//
//  SimplePOPAnimationState.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/27.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation

class SimplePOPAnimationState {
    
    weak var _animation : SimplePOPAnimation?
    var _beginTime : CFTimeInterval = 0.0
    var _isStarted = false
    var currentValue : [CGFloat]?
    
    init() {
    }
    
    func isStart() -> Bool {
        return _isStarted
    }
    func startIfNeed() {
        if _isStarted{
            return
        }
        _isStarted = true
        _beginTime = CACurrentMediaTime();
        NSLog("%@, beginTime:\(_beginTime)", #function)
    }
    
    func applyAnimationTime(obj:NSObject, time: CFTimeInterval) ->Bool {
        NSLog("%@\(time)", #function)
        return self.advanceTime(time, obj: obj)
    }
    
    func advanceTime(time:CFTimeInterval, obj: NSObject) -> Bool {
    
        return false
    }
}