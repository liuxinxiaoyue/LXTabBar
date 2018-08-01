//
//  LXMessageItem.swift
//  LXTabBarCode
//
//  Created by admin on 2018/7/26.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class LXMessageItem: LXTabItem {

    private var faceLayer: CAShapeLayer = {
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
    private var rightEyeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 1.4
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()
    private var mouthLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 1.6
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()
    
    override func stepImageContent() {
        // 面部
        imageLayer.addSublayer(faceLayer)
        // 左眼
        imageLayer.addSublayer(leftEyeLayer)
        // 右眼
        imageLayer.addSublayer(rightEyeLayer)
        // 嘴
        imageLayer.addSublayer(mouthLayer)
    }
    
    override func generatePath() {

        super.generatePath()
        //
        let temp = imageRect
        let width: CGFloat = 25.0
        let r: CGFloat = 12.5
        let pathRect = CGRect(x: (temp.width - width) / 2, y: temp.minY, width: width, height: width)
        let center = CGPoint(x: pathRect.minX + pathRect.width / 2, y: pathRect.height / 2)
        let angle = Double.pi * 53 / 180
        //
        let path = UIBezierPath(arcCenter: center, radius: r, startAngle: CGFloat(Double.pi / 2 + angle), endAngle: CGFloat(Double.pi * 5 / 2), clockwise: true)
        let endPoint = CGPoint(x: center.x - r - 2, y: center.y + 6)
        let control = CGPoint(x: center.x - (r + 4) / 2 - 2, y: center.y + r)
        path.addQuadCurve(to: endPoint, controlPoint: control)
        path.addQuadCurve(to: CGPoint(x: center.x - r * CGFloat(sin(angle)), y: center.y + r * CGFloat(cos(angle))), controlPoint: CGPoint(x: endPoint.x + 0.5, y: endPoint.y + 1))
        faceLayer.path = path.cgPath
        faceLayer.fillColor = state == .normal ? UIColor.white.cgColor : UIColor(hexString: "48bcf5").cgColor
        faceLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : UIColor(hexString: "48bcf5").cgColor
        faceLayer.frame = imageLayer.bounds
        
        //
        let distance: CGFloat = 7
        var x: CGFloat = 0
        if lookDirection == .right {
            x = center.x - 1
        } else {
            x = center.x - distance / 2
        }
        let leftEyePath = UIBezierPath()
        let lBegin = CGPoint(x: x, y:  8)
        let lEnd = CGPoint(x: lBegin.x, y: lBegin.y + 3)
        leftEyePath.move(to: lBegin)
        leftEyePath.addLine(to: lEnd)
        leftEyeLayer.path = leftEyePath.cgPath
        leftEyeLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : UIColor.white.cgColor
        leftEyeLayer.frame = imageLayer.bounds
        //
        let rightEyePath = UIBezierPath()
        let rBegin = CGPoint(x: lBegin.x + distance, y: lBegin.y)
        let rEnd = CGPoint(x: rBegin.x, y: rBegin.y + 3)
        rightEyePath.move(to: rBegin)
        rightEyePath.addLine(to: rEnd)
        rightEyeLayer.path = rightEyePath.cgPath
        rightEyeLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : UIColor.white.cgColor
        rightEyeLayer.frame = imageLayer.bounds
        //
        let mouthPath = UIBezierPath()
        let mBegin = CGPoint(x: lBegin.x, y: lEnd.y + 5)
        let mEnd = CGPoint(x: rBegin.x, y: mBegin.y)
        mouthPath.move(to: mBegin)
        mouthPath.addQuadCurve(to: mEnd, controlPoint: CGPoint(x: mBegin.x + distance / 2, y: mBegin.y + 5))
        mouthLayer.path = mouthPath.cgPath
        mouthLayer.fillColor = state == .normal ? UIColor.white.cgColor : UIColor.white.cgColor
        mouthLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : nil
        mouthLayer.frame = imageLayer.bounds
    }
}
