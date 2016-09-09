//
//  ViewController.swift
//  SimplePOPDemo
//
//  Created by xianmingchen on 16/8/25.
//  Copyright © 2016年 xianmingchen. All rights reserved.
//

import UIKit
import SimplePOP
class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonTapped(sender: AnyObject) {
        let button = sender as! UIButton
        
        if (!button.selected) {
            let animation : SimplePOPBasicAnimation = SimplePOPBasicAnimation.animationWithPropertyNamed(kSimplePOPPosition)
            animation.formValue = self.animationView.layer.position
            var from = animation.formValue
            NSLog("%@, fromValue: %@", NSStringFromCGPoint(from!), #function)
            from!.y += 200
            animation.toValue = from
            animation.timingFunctionType = SimplePOPTimingFunctionType.BounceEaseOut
            
            NSLog("%@, toValue: %@", NSStringFromCGPoint(from!), #function)
            self.animationView.layer.simplePOP_addAnimation(animation, withKey:"TextKey")
            button.selected = true
        }
        else
        {
            button.selected = false
            self.animationView.layer.simplePOP_removeAnimationWithKey("TextKey")
            var position = self.animationView.layer.position
            position.y -= 200
            self.animationView.layer.position = position
        }
    }
    
        // Do any additional setup after loading the view, typically from a nib.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
}

