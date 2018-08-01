//
//  LXContactItem.swift
//  LXTabBarCode
//
//  Created by admin on 2018/7/26.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class LXContactItem: LXTabItem {

    private var headLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 1.5
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()

    private var leftEyeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 1.4
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()
    
    private var righEyeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 1.4
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()
    
    private var mouthLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()
    
    private var bodyLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 1.5
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lookDirection = .left
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lookDirection = .left
    }
    
    //MARK: - 重写
    override func stepImageContent() {
        //
        imageLayer.addSublayer(headLayer)
        //
        imageLayer.addSublayer(leftEyeLayer)
        //
        imageLayer.addSublayer(righEyeLayer)
        //
        imageLayer.addSublayer(mouthLayer)
        //
        imageLayer.addSublayer(bodyLayer)
    }
    
    override func generatePath() {
        super.generatePath()
        //
        let temp = imageRect
        let pathWidth: CGFloat = 25.0
        let pathRect = CGRect(x: (temp.width - pathWidth) / 2, y: temp.minY, width: pathWidth, height: pathWidth)
        //
        let headWidth: CGFloat = 14.0
        let r = headWidth / 2
        let headCenter = CGPoint(x: pathRect.minX + (pathWidth - headWidth) / 2 + r, y: r)
        let headPath = UIBezierPath(arcCenter: headCenter, radius: r, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        headLayer.path = headPath.cgPath
        headLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : UIColor(hexString: "48bcf5").cgColor
        headLayer.fillColor = state == .normal ? UIColor.white.cgColor : UIColor(hexString: "48bcf5").cgColor
        headLayer.frame = imageLayer.bounds
        //
        let distance: CGFloat = 4
        var x: CGFloat = 0
        if lookDirection == .left {
            x = headCenter.x + 1 - distance
        } else if lookDirection == .center {
            x = headCenter.x - distance / 2
        } else if lookDirection == .right {
            x = headCenter.x - 1
        }
        let lBegin = CGPoint(x: x, y: 5)
        let lEnd = CGPoint(x: lBegin.x, y: lBegin.y + 2)
        let lPath = UIBezierPath()
        lPath.move(to: lBegin)
        lPath.addLine(to: lEnd)
        leftEyeLayer.path = lPath.cgPath
        leftEyeLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : UIColor.white.cgColor
        leftEyeLayer.frame = imageLayer.bounds
        //
        let rBegin = CGPoint(x: lBegin.x + distance, y: lBegin.y)
        let rEnd = CGPoint(x: rBegin.x, y: rBegin.y + 2)
        let rPath = UIBezierPath()
        rPath.move(to: rBegin)
        rPath.addLine(to: rEnd)
        righEyeLayer.path = rPath.cgPath
        righEyeLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : UIColor.white.cgColor
        righEyeLayer.frame = imageLayer.bounds
        //
        let mr = distance / 2
        let mCenter = CGPoint(x: lBegin.x + mr, y: lBegin.y + 4)
        let mPath = UIBezierPath(arcCenter: mCenter, radius: mr, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)
        mouthLayer.path = mPath.cgPath
        mouthLayer.fillColor = UIColor.white.cgColor
        mouthLayer.frame = imageLayer.bounds
        //
        let bodyHeight: CGFloat = 10.0
        let bBegin = CGPoint(x: pathRect.minX, y: headCenter.y + r + 1 + bodyHeight)
        let bEnd = CGPoint(x: bBegin.x + pathWidth, y: bBegin.y)
        let control1 = CGPoint(x: bEnd.x - 0.0, y: bEnd.y - bodyHeight - 0.3)
        let control2 = CGPoint(x: bBegin.x + 0.0, y: bBegin.y - bodyHeight - 0.3)
        let bPath = UIBezierPath()
        bPath.move(to: bBegin)
        bPath.addLine(to: bEnd)
        bPath.addCurve(to: bBegin, controlPoint1: control1, controlPoint2: control2)
        bodyLayer.path = bPath.cgPath
        bodyLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : UIColor(hexString: "48bcf5").cgColor
        bodyLayer.fillColor = state == .normal ? UIColor.white.cgColor : UIColor(hexString: "48bcf5").cgColor
        bodyLayer.frame = imageLayer.bounds
    }
}
