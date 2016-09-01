//
//  SimplePOPMath.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/29.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation

func interpolate(from: CGFloat, to: CGFloat, time: CGFloat) -> CGFloat {
    return (to - from) * time + from
}

func interpolateFromValue(fromValues:[CGFloat], toValues:[CGFloat], time:CGFloat) ->([CGFloat]?, Bool) {
    let fromCount = fromValues.count
    let toCount = toValues.count
    var resultValues = [CGFloat]()
    if fromCount == toCount && fromCount > 0 {
        for i in 0...toCount - 1
        {
            let fromValue = fromValues[i]
            let toValue = toValues[i]
            let resultValue = interpolate(fromValue, to: toValue, time: time)
            resultValues.append(resultValue)
        }
        
        return (resultValues, true)
    }
    else
    {
        return (nil, false)
    }
}

//转化到0～1区间
func timeWithBeginTime(begingTime: CFTimeInterval, duration: CFTimeInterval, currentTime:CFTimeInterval) ->(time:CGFloat, isEnd: Bool){
    var end = false
    if currentTime < begingTime {
        return (0.0 , end)
    }
    
    let increaseTime = currentTime - begingTime
    if increaseTime > duration {
        end = true
    }
    
    return (CGFloat(min(increaseTime, duration) / duration), end)
}

//一次函数即线性
func timingFunctionLiner(time:CGFloat)->CGFloat {
    return 1 * time
}

//二次函数数
func timingFunctionSquare(time:CGFloat)->CGFloat {
    return time * time
}

//这个网上找的算法
func timingFunctionBounceEaseOut(time:CGFloat)->CGFloat
{
    if (time < 4/11.0) {
        return (121 * time * time)/16.0;
    } else if (time < 8/11.0) {
        return (363/40.0 * time * time) - (99/10.0 * time) + 17/5.0;
    } else if (time < 9/10.0) {
        return (4356/361.0 * time * time) - (35442/1805.0 * time) + 16061/1805.0;
    }
    return (54/5.0 * time * time) - (513/25.0 * time) + 268/25.0;
}
