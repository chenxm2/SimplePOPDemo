//
//  SimplePOPAnimator.swift
//  SimplePOP
//
//  Created by xianmingchen on 16/8/25.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import Foundation

class SimplePOPAnimator: NSObject {

    static let sharedInstance = SimplePOPAnimator()
    private var _itemArray = Array<POPAinmatortItem>()
    private var _dic = Dictionary<Int, Dictionary<String, SimplePOPAnimation>>()
    var _lock:OSSpinLock = OS_SPINLOCK_INIT
    var _displayLink : CADisplayLink?
    
    override init() {
        super.init()
        _displayLink = CADisplayLink(target: self, selector: #selector(update))
        _displayLink!.frameInterval = 1
        _displayLink!.paused = false
        _displayLink!.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func update(displayLink: CADisplayLink) {
        let currentTime = CACurrentMediaTime()
        self.renderWithTime(currentTime)
    }
    
    func addAnimation(aninamtion: SimplePOPAnimation, forObject obj:NSObject, withKey key: String) {
        
        var keyAnimationDict = self.dicForObject(obj)
        if (keyAnimationDict == nil) {
            _ = SimplePOPLock(lock: &_lock)
            keyAnimationDict = Dictionary<String, SimplePOPAnimation>()
            self.setDicForObject(obj, dic: keyAnimationDict!);
        }
        else
        {
            let existingAnim = keyAnimationDict![key]
            if existingAnim != nil {
                if existingAnim == aninamtion {
                    return;
                }
                self.removeAnimationWithKey(key, obj: obj, cleanup: false)
            }
        }
        
        do {
            _ = SimplePOPLock(lock: &_lock)
            keyAnimationDict![key] = aninamtion
            let animationItem = POPAinmatortItem (o: obj, k: key, a: aninamtion)
            _itemArray.append(animationItem)
        }
    }
    
    func removeAnimationWithKey(key:String, obj:NSObject) {
        self.removeAnimationWithKey(key, obj: obj)
    }

    
    deinit{
        NSLog("deinit")
    }

    
    //MARK: Private Func
    private func renderWithTime(time:CFTimeInterval){
        NSLog("%@, time: \(time)", #function)
        self.renderWithTime(time, items: _itemArray)
    }
    
    private func renderWithTime(time:CFTimeInterval, items:Array<POPAinmatortItem>){
        for item in items {
            self.renderWithTime(time, item: item)
        }
        
    }
    
    private func renderWithTime(time:CFTimeInterval, item: POPAinmatortItem){
        let obj = item.object
        let animation = item.animation
        let animationState = animation._animationState
        if (animationState.isStart()) {
                
            if animationState.applyAnimationTime(obj!, time: time) {
                let wirteBlock : sp_pop_animatable_write_block?  = (animationState as! SimplePOPPropertyAnimationState).property?.writeBlock
                if (wirteBlock != nil) {
                        wirteBlock!(object:obj!, values:&(animationState.currentValue!), valueCount:(animationState.currentValue?.count)!)
                }
            }  
        }
        else {
            animationState.startIfNeed()
        }
    }
    
    private func dicForObject(obj: NSObject) ->Dictionary<String, SimplePOPAnimation>? {
        let dic = _dic[obj.hash]
        return dic
    }
    
    private func setDicForObject(obj:NSObject, dic:Dictionary<String, SimplePOPAnimation>) {
        _dic[obj.hash] = dic;
    }
    
    private func animationWithKey(key:String, obj:NSObject) ->SimplePOPAnimation?{
        var animation : SimplePOPAnimation?
        let dic = self.dicForObject(obj);
        if dic != nil {
            animation = dic![key]
        }
        
        return animation;
    }
    
    private func removeAnimationWithKey(key: String, obj:NSObject, cleanup:Bool){
        _ = SimplePOPLock(lock: &_lock)
        var keyAnimationDict = _dic[obj.hash]
        if (keyAnimationDict != nil) {
            _ = SimplePOPLock(lock: &_lock)
            let animation = keyAnimationDict![key]
            if (animation != nil) {
                keyAnimationDict?.removeValueForKey(key);
                if keyAnimationDict?.count == 0 && cleanup {
                    _dic.removeValueForKey(obj.hash)
                }
                
                //deleteItem in Array
                self.removeAinmatortItemWithAnimation(animation!)
            }
        }
    }
    
    private func removeAinmatortItemWithAnimation(animation: SimplePOPAnimation) {
        _ = SimplePOPLock(lock: &_lock)
        if _itemArray.count <= 0 {
            return;
        }
        
        _itemArray = _itemArray.filter { item -> Bool in
           return item.animation != animation
        }
    }
    
    class POPAinmatortItem
    {
        weak var object : NSObject?
        var key : String
        var animation : SimplePOPAnimation
        unowned var unretainedObject : NSObject
        
        init(o:NSObject, k:String, a:SimplePOPAnimation) {
            object = o
            key = k
            animation = a
            unretainedObject = o
        }
    }
}
