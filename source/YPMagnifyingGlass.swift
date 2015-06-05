//
//  YPMagnifyingGlass.swift
//  YPMagnifyingGlass
//
//  Created by Geert-Jan Nilsen on 02/06/15.
//  Copyright (c) 2015 Yuppielabel.com All rights reserved.
//

import UIKit
import QuartzCore

public class YPMagnifyingGlass: UIView {

  public var viewToMagnify: UIView!
  public var touchPoint: CGPoint! {
    didSet {
      self.center = CGPointMake(touchPoint.x + touchPointOffset.x, touchPoint.y + touchPointOffset.y)
    }
  }
  
  public var touchPointOffset: CGPoint!
  public var scale: CGFloat!
  public var scaleAtTouchPoint: Bool!
  
  public var YPMagnifyingGlassDefaultRadius: CGFloat = 40.0
  public var YPMagnifyingGlassDefaultOffset: CGFloat = -40.0
  public var YPMagnifyingGlassDefaultScale: CGFloat = 2.0
  
  public func initViewToMagnify(viewToMagnify: UIView, touchPoint: CGPoint, touchPointOffset: CGPoint, scale: CGFloat, scaleAtTouchPoint: Bool) {
  
    self.viewToMagnify = viewToMagnify
    self.touchPoint = touchPoint
    self.touchPointOffset = touchPointOffset
    self.scale = scale
    self.scaleAtTouchPoint = scaleAtTouchPoint
  
  }

  required public init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  required public override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.layer.borderColor = UIColor.lightGrayColor().CGColor
    self.layer.borderWidth = 3
    self.layer.cornerRadius = frame.size.width / 2
    self.layer.masksToBounds = true
    self.touchPointOffset = CGPointMake(0, YPMagnifyingGlassDefaultOffset)
    self.scale = YPMagnifyingGlassDefaultScale
    self.viewToMagnify = nil
    self.scaleAtTouchPoint = true
  }
  
  private func setFrame(frame: CGRect) {
    super.frame = frame
    self.layer.cornerRadius = frame.size.width / 2
  }
  
  public override func drawRect(rect: CGRect) {
    var context: CGContextRef = UIGraphicsGetCurrentContext()
    CGContextTranslateCTM(context, self.frame.size.width/2, self.frame.size.height/2)
    CGContextScaleCTM(context, self.scale, self.scale)
    CGContextTranslateCTM(context, -self.touchPoint.x, -self.touchPoint.y + (self.scaleAtTouchPoint != nil ? 0 : self.bounds.size.height/2))
    self.viewToMagnify.layer.renderInContext(context)
  }
}
