//
//  SimplePOPAnimationRuntime.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/27.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation
typealias sp_pop_animatable_read_block = (object: NSObject, inout values:[CGFloat], valueCount:Int) ->Void
typealias sp_pop_animatable_write_block = (object: NSObject, inout values: [CGFloat], valueCount:Int) ->Void