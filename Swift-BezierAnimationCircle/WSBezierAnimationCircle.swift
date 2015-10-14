//
//  WSBezierAnimationPageControl.swift
//  
//
//  Created by caiwenshu on 10/13/15.
//
//

import UIKit

class WSBezierAnimationCircle: UIView {

    
    let outsideRectSize:CGFloat = 100
    
    var outsideRect:CGRect = CGRectZero
    
    var progress:CGFloat = 0.5
    
    
    let POINT_B:Int = 0
    let POINT_D:Int = 1
    
    var movePoint:Int = 0
    
    override init(frame: CGRect) {
       
        super.init(frame: frame)
        
        var origin_x:CGFloat = self.bounds.size.width / 2 - outsideRectSize / 2 + (progress - 0.5) * (self.bounds.size.width - outsideRectSize)
        
        var origin_y:CGFloat = self.bounds.size.height / 2 - outsideRectSize / 2 + (progress - 0.5) * (self.bounds.size.height - outsideRectSize)
        
        self.outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize)
        
//        self.outsideRect =
        
        self.backgroundColor = UIColor.brownColor()
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
     
        super.init(coder: aDecoder)
        
    }
    
    override func drawRect(rect: CGRect) {
        
        var context:CGContextRef = UIGraphicsGetCurrentContext();
        self .drawInContent(context)
    }
    
    
    func drawInContent(ctx:CGContextRef)
    {
     
        var offset:CGFloat = self.outsideRect.size.width / 3.6
        
        var movedDistance:CGFloat = (self.outsideRect.size.width * 1 / 6) * fabs(self.progress - 0.5) * 2
        
        var rectCenter:CGPoint = CGPointMake(self.outsideRect.origin.x + self.outsideRect.size.width / 2, self.outsideRect.origin.y + self.outsideRect.size.height / 2)
        
        
        var pointA:CGPoint = CGPointMake(rectCenter.x, self.outsideRect.origin.y + movedDistance)
        
        var pointB:CGPoint = CGPointMake(self.movePoint == POINT_D ? rectCenter.x + self.outsideRect.size.width / 2 : rectCenter.x + self.outsideRect.size.width / 2 + movedDistance * 2  , rectCenter.y)
        
        var pointC:CGPoint = CGPointMake(rectCenter.x, rectCenter.y + self.outsideRect.size.height / 2 - movedDistance)
        
        var pointD:CGPoint = CGPointMake(self.movePoint == POINT_D ? rectCenter.x - self.outsideRect.size.width / 2 - 2 * movedDistance : rectCenter.x - self.outsideRect.size.width / 2, rectCenter.y)
        
        
        var c1:CGPoint = CGPointMake(pointA.x + offset, pointA.y)
        var c2:CGPoint = CGPointMake(pointB.x, self.movePoint == POINT_D ? pointB.y - offset : pointB.y - offset + movedDistance)
        var c3:CGPoint = CGPointMake(pointB.x, self.movePoint == POINT_D ? pointB.y + offset : pointB.y + offset - movedDistance)
        var c4:CGPoint = CGPointMake(pointC.x + offset, pointC.y)
        var c5:CGPoint = CGPointMake(pointC.x - offset, pointC.y)
        var c6:CGPoint = CGPointMake(pointD.x, self.movePoint == POINT_D ?  pointD.y + offset - movedDistance : pointD.y + offset)
        var c7:CGPoint = CGPointMake(pointD.x, self.movePoint == POINT_D ?  pointD.y - offset + movedDistance : pointD.y - offset)
        var c8:CGPoint = CGPointMake(pointA.x - offset, pointA.y)
        
        
        var ovalPath:UIBezierPath = UIBezierPath()
        ovalPath .moveToPoint(pointA)
        ovalPath .addCurveToPoint(pointB, controlPoint1: c1, controlPoint2: c2)
        ovalPath .addCurveToPoint(pointC, controlPoint1: c3, controlPoint2: c4)
        ovalPath .addCurveToPoint(pointD, controlPoint1: c5, controlPoint2:c6)
        ovalPath .addCurveToPoint(pointA, controlPoint1: c7, controlPoint2: c8)
        ovalPath .closePath()
        
        var rectPath:UIBezierPath = UIBezierPath(rect: self.outsideRect)

        CGContextAddPath(ctx, rectPath.CGPath)
        
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(ctx, 1)
        var dash:[CGFloat] = [5.0, 5.0]
        CGContextSetLineDash(ctx, 0, dash, 2) //1
        
        CGContextStrokePath(ctx)
        CGContextAddPath(ctx, ovalPath.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextSetLineDash(ctx, 0, nil, 0) // 2
        CGContextDrawPath(ctx, kCGPathFillStroke)
        
        
        CGContextSetFillColorWithColor(ctx, UIColor.yellowColor().CGColor)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        var points:[CGPoint] = [c1,c2,c3,c4,c5,c6,c7,c8]
        
        
        drawPoint(points, withContent: ctx)
        
        var helperLine:UIBezierPath = UIBezierPath()
        helperLine .moveToPoint(pointA)
        helperLine .addLineToPoint(c1)
        helperLine .addLineToPoint(c2)
        
        helperLine .addLineToPoint(pointB)
        helperLine .addLineToPoint(c3)
        helperLine .addLineToPoint(c4)
        
        helperLine .addLineToPoint(pointC)
        helperLine .addLineToPoint(c5)
        helperLine .addLineToPoint(c6)
        
        helperLine .addLineToPoint(pointD)
        helperLine .addLineToPoint(c7)
        helperLine .addLineToPoint(c8)
        
        helperLine .closePath()
        
        CGContextAddPath(ctx, helperLine.CGPath)
        
        var dash2:[CGFloat] = [2.0 ,2.0]
        CGContextSetLineDash(ctx, 0, dash2, 2)
        CGContextStrokePath(ctx) //给辅助线条填充颜色”x
        
        CGContextSetFillColorWithColor(ctx, UIColor.blueColor().CGColor)
        drawPoint([pointA,pointB,pointC,pointD], withContent: ctx)
        
        
    }
    
    
    func drawPoint(points:[CGPoint],  withContent ctx:CGContextRef)
    {
        
        for point in points
        {
            CGContextFillRect(ctx, CGRectMake(point.x - 2, point.y - 2, 4, 4))
        }
        
    }
    
    
    
    
    
}
