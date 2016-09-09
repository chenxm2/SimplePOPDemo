//
//  SimplePOPBasicAnimationState.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/27.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation

public enum SimplePOPTimingFunctionType {
    case Liner
    case Square
    case BounceEaseOut
}

class SimplePOPBasicAnimationState: SimplePOPPropertyAnimationState {
    var duration : CFTimeInterval

    var timingFunctionType : SimplePOPTimingFunctionType = .Liner
    override init (){
        duration = 1
    }
    
    
    override func advanceTime(time: CFTimeInterval, obj: NSObject) -> Bool {
        NSLog("%@\(time)", #function)
        var result = false
        
        if self.fromValue == nil || self.toValue == nil  {
            return false
        }
        
        var (tempTime, isEnd) = timeWithBeginTime(self._beginTime, duration: self.duration, currentTime: time)
        if isEnd {
            return false;
        }
        
        NSLog("%@ begin tempTIme:\(tempTime)", #function)
        
        var resultTime : CGFloat?
        switch timingFunctionType {
        case .Liner:
            tempTime = timingFunctionLiner(tempTime)
        case .Square:
            tempTime = timingFunctionSquare(tempTime)
        case .BounceEaseOut:
            tempTime = timingFunctionBounceEaseOut(tempTime)
        }
        
        NSLog("%@ end tempTIme:\(tempTime)", #function)
        
        resultTime = tempTime
        
        var fromValues = [CGFloat]()
        var toValues = [CGFloat]()
        fromValues.append(self.fromValue!.x)
        fromValues.append(self.fromValue!.y)
        toValues.append(self.toValue!.x)
        toValues.append(self.toValue!.y)
        
        
        let (resultValues, isSuccess) = interpolateFromValue(fromValues, toValues: toValues, time: resultTime!);
        if isSuccess {
             NSLog("%@ result:\(resultValues)", #function)
            if self.currentValue == nil {
                self.currentValue = resultValues
            }
            else
            {
                if self.currentValue! != resultValues! {
                    self.currentValue = resultValues;
                        result = true
                }
                else{
                    result = false
                }
            }
        }
        else
        {
            result = false
        }
        return result
    }
}