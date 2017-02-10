//
//  YPMagnifyingView.swift
//  YPMagnifyingGlass
//
//  Created by Geert-Jan Nilsen on 02/06/15.
//  Copyright (c) 2015 Yuppielabel.com All rights reserved.
//

import UIKit

public class YPMagnifyingView: UIView {
    
    private var magnifyingGlassShowDelay: TimeInterval = 0.2
    
    private var touchTimer: Timer!
    
    public var magnifyingGlass: YPMagnifyingGlass = YPMagnifyingGlass()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Touch Events
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            
            self.touchTimer = Timer.scheduledTimer(timeInterval: magnifyingGlassShowDelay, target: self, selector: #selector(YPMagnifyingView.addMagnifyingGlassTimer(timer:)), userInfo: NSValue(cgPoint: touch.location(in: self)), repeats: false)
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            self.updateMagnifyingGlassAtPoint(point: touch.location(in: self))
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchTimer.invalidate()
        self.touchTimer = nil
        
        self.removeMagnifyingGlass()
    }
    
    // MARK: - Private Functions
    
    private func addMagnifyingGlassAtPoint(point: CGPoint) {
        self.magnifyingGlass.viewToMagnify = self as UIView
        self.magnifyingGlass.touchPoint = point
        
        let selfView: UIView = self as UIView
        
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
    
    public func addMagnifyingGlassTimer(timer: Timer) {
        let value: AnyObject? = timer.userInfo as AnyObject?
        if let point = value?.cgPointValue {
            self.addMagnifyingGlassAtPoint(point: point)
        }
    }
}
