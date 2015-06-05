//
//  YPMagnifyingView.swift
//  YPMagnifyingGlass
//
//  Created by Geert-Jan Nilsen on 02/06/15.
//  Copyright (c) 2015 Yuppielabel.com All rights reserved.
//

import UIKit

public class YPMagnifyingView: UIView {
  
  public var YPMagnifyingViewDefaultShowDelay: NSTimeInterval = 0.2;
  
  private var magnifyingGlassShowDelay: NSTimeInterval
  
  private var touchTimer: NSTimer!
  
  public var magnifyingGlass: YPMagnifyingGlass = YPMagnifyingGlass()
  
  override public init(frame: CGRect) {
    self.magnifyingGlassShowDelay = YPMagnifyingViewDefaultShowDelay
    super.init(frame: frame)
  }
  
  required public init(coder aDecoder: NSCoder) {
    self.magnifyingGlassShowDelay = YPMagnifyingViewDefaultShowDelay
    super.init(coder: aDecoder)
  }
  
  // MARK: - Touch Events
  override public func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    if let touch: UITouch = touches.first as? UITouch {
      
      self.touchTimer = NSTimer.scheduledTimerWithTimeInterval(magnifyingGlassShowDelay, target: self, selector: Selector("addMagnifyingGlassTimer:"), userInfo: NSValue(CGPoint: touch.locationInView(self)), repeats: false)
    }
  }
  
  override public func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
    if let touch: UITouch = touches.first as? UITouch {
      self.updateMagnifyingGlassAtPoint(touch.locationInView(self))
    }
  }
  
  override public func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    self.touchTimer.invalidate()
    self.touchTimer = nil
    
    self.removeMagnifyingGlass()
  }
  
  // MARK: - Private Functions
  
  private func addMagnifyingGlassAtPoint(point: CGPoint) {
    self.magnifyingGlass.viewToMagnify = self as UIView
    self.magnifyingGlass.touchPoint = point
    
    let selfView: UIView = self as UIView
    let superView: UIView = self.superview!
    
    selfView.addSubview(self.magnifyingGlass)
    
    self.magnifyingGlass.setNeedsDisplay()
  }
  
  private func removeMagnifyingGlass() {
    self.magnifyingGlass.removeFromSuperview()
  }
  
  private func updateMagnifyingGlassAtPoint(point: CGPoint) {
    self.magnifyingGlass.touchPoint = point
    self.magnifyingGlass.setNeedsDisplay()
  }
  
  public func addMagnifyingGlassTimer(timer: NSTimer) {
    let value: AnyObject? = timer.userInfo
    if let point = value?.CGPointValue() {
      self.addMagnifyingGlassAtPoint(point)
    }
  }
}
