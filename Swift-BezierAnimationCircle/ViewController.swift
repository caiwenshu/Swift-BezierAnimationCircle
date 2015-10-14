//
//  ViewController.swift
//  Swift-BezierPageControl
//
//  Created by caiwenshu on 10/13/15.
//  Copyright (c) 2015 caiwenshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pageControl:WSBezierAnimationCircle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.pageControl = WSBezierAnimationCircle(frame: CGRectMake(40.0, 40.0, 300.0, 300.0))
        self.view .addSubview(self.pageControl!)
        
        
        var slide:UISlider = UISlider(frame: CGRectMake(40.0, 400.0, 300.0, 40.0))
        slide.minimumValue = 0
        slide.maximumValue = 1
        slide.value = 0.5
        slide .addTarget(self, action: Selector("slideValueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        self.view .addSubview(slide)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func slideValueChange(slide:UISlider)
    {
        self.pageControl!.progress = CGFloat(slide.value)
        
        //只要外接矩形在左侧，则改变B点；在右边，改变D点
        if (self.pageControl!.progress <= 0.5) {
            
            self.pageControl!.movePoint = self.pageControl!.POINT_B;
            NSLog("B点动");
        }else{
            self.pageControl!.movePoint = self.pageControl!.POINT_D;
            NSLog("D点动");
        }
        
        
        self.pageControl! .setNeedsDisplay()
    }
    
}

