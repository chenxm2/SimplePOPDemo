//
//  SimplePOPLock.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/26.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation
class SimplePOPLock: AnyObject {
    
    let _lock : UnsafeMutablePointer<OSSpinLock>
    init(lock: UnsafeMutablePointer<OSSpinLock>) {
        _lock = lock;
        OSSpinLockLock(_lock); 
    }
    
    deinit {
        // perform the deinitialization
        OSSpinLockUnlock(_lock)
    }
}
