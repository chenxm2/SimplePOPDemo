//
//  SimplePOPAnimatableProperty.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/25.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation
import UIKit
struct SimplePOPAnimatablePropertyState {
    let name : String?
    let readBlock : sp_pop_animatable_read_block?
    let writeBlock: sp_pop_animatable_write_block?
    let threshold : CGFloat?
}

public let kSimplePOPPosition = "SimplePOPSimplePOPPosition"

let _staticStates : [SimplePOPAnimatablePropertyState] = [
                    SimplePOPAnimatablePropertyState(name:kSimplePOPPosition,
                    readBlock: {(object: NSObject, inout values:[CGFloat], valueCount:Int) in
                        if object is CALayer  && valueCount == 2 {
                            var layer : CALayer = object as! CALayer
                            let position = layer.position
                            values[0] = position.x
                            values[1] = position.y
                            
                        }
                    },
                    writeBlock: {(object: NSObject, inout values:[CGFloat], valueCount:Int) in
                        if object is CALayer  && valueCount == 2 {
                            NSLog("%@ writeBlock \(values)", #function)
                            var layer : CALayer = object as! CALayer
                            var position = layer.position
                            position.x = values[0]
                            position.y = values[1]
                            layer.position = position
                            
                        }
                    },
                    threshold:1.0)]


class SimplePOPAnimatableProperty{

    private var propertyState : SimplePOPAnimatablePropertyState?
    
    static func propertyWithName(name:String) ->SimplePOPAnimatableProperty{
        let property = SimplePOPAnimatableProperty()
        for state in _staticStates {
            if state.name == name {
                property.propertyState = state
                break
            }
        }
        return property
    }
    
    var readBlock : sp_pop_animatable_read_block? {
        get {
            return self.propertyState?.readBlock
        }
    }
    var writeBlock : sp_pop_animatable_write_block? {
        get {
            return self.propertyState?.writeBlock
        }
    }
}

