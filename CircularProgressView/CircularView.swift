//
//  CircularView.swift
//  CircularProgressView
//
//  Created by Nitin on 20/05/20.
//  Copyright © 2020 Nitin. All rights reserved.
//

import UIKit

@IBDesignable class CircularView: UIView {
    
    var progressLyr : CAShapeLayer?
    var trackLyr : CAShapeLayer?
    var lbl = UILabel()
    
    
    @IBInspectable var progressClr:UIColor = UIColor() {
        didSet{
            progressLyr = CAShapeLayer()
            progressLyr!.strokeColor = progressClr.cgColor
        }
    }
    
    @IBInspectable var trackClr:UIColor = UIColor() {
        didSet {
            trackLyr = CAShapeLayer()
            trackLyr!.strokeColor = trackClr.cgColor
        }
    }
    
    func setProgressWithAnimation(duration: TimeInterval, toValue: Float,fromValue:Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLyr!.strokeEnd = CGFloat(toValue)
        progressLyr!.add(animation, forKey: "animateprogress")
        lbl.text = String(format: "%.0f", (toValue * 100)) + "%"
    }
    
    func makeCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2, y: frame.size.height/2), radius: (frame.size.width - 1.5)/2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLyr!.path = circlePath.cgPath
        trackLyr!.fillColor = UIColor.clear.cgColor
        trackLyr!.strokeColor = trackClr.cgColor
        trackLyr!.lineWidth = 5.0
        trackLyr!.strokeEnd = 1.0
        layer.addSublayer(trackLyr!)
        progressLyr!.path = circlePath.cgPath
        progressLyr!.fillColor = UIColor.clear.cgColor
        progressLyr!.strokeColor = progressClr.cgColor
        progressLyr!.lineWidth = 10.0
        progressLyr!.strokeEnd = 0.0
        layer.addSublayer(progressLyr!)
        
        self.addSubview(lbl)
        lbl.text = "0.0 %"
        lbl.frame = CGRect(x: 0, y: self.frame.height / 2 - 30, width: self.frame.width, height: 30)
        lbl.textAlignment = .center
        lbl.textColor = .black
    }
    
    
}
