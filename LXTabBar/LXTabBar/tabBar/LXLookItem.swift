//
//  LXLookItem.swift
//  LXTabBarCode
//
//  Created by admin on 2018/7/26.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class LXLookItem: LXTabItem {

    private var upLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        //layer.strokeColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.5
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()

    private var cicleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        //layer.strokeColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.5
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()
    
    private var downLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        //layer.strokeColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 1.5
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        return layer
    }()
    
    //MARK: - 重写
    override func stepImageContent() {
        //
        imageLayer.addSublayer(upLayer)
        //
        imageLayer.addSublayer(downLayer)
        //
        imageLayer.addSublayer(cicleLayer)
    }
    
    override func generatePath() {
        super.generatePath()
        let selectColor = UIColor(hexString: "48bcf5").cgColor
        //
        let temp = imageRect
        let pathWidth: CGFloat = 25.0
        let pathRect = CGRect(x: (temp.width - pathWidth) / 2, y: temp.minY, width: pathWidth, height: pathWidth)
        
        //
        let uBegin = CGPoint(x: pathRect.minX, y: 10)
        let uMid1 = CGPoint(x: uBegin.x + 7, y: uBegin.y - 7)
        let uControl = CGPoint(x: pathRect.minX + pathWidth / 2, y: -1)
        let uMid2 = CGPoint(x: uMid1.x + 10, y: uMid1.y)
        let uEnd = CGPoint(x: uBegin.x + pathWidth - 1, y: uBegin.y - 2)
        let uPath = UIBezierPath()
        uPath.move(to: uBegin)
        uPath.addLine(to: uMid1)
        uPath.addQuadCurve(to: uMid2, controlPoint: uControl)
        uPath.addLine(to: uEnd)
        if state == .selected {
            let uInControl1 = CGPoint(x: uEnd.x - 2, y: uEnd.y + 2)
            let uInControl2 = CGPoint(x: uControl.x, y: uControl.y + 1)
            let uInEnd = CGPoint(x: uMid1.x, y: uMid1.y + 2)
            uPath.addCurve(to: uInEnd, controlPoint1: uInControl1, controlPoint2: uInControl2)
            uPath.addQuadCurve(to: uBegin, controlPoint: CGPoint(x: uBegin.x - 1, y: uBegin.y + 1))
        }
        upLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : selectColor
        //upLayer.fillColor = state == .normal ? UIColor.white.cgColor : selectColor
        upLayer.path = uPath.cgPath
        upLayer.lineWidth = state == .normal ? 1.5 : 3.0
        upLayer.frame = imageLayer.bounds
        //
        let center = CGPoint(x: pathRect.minX + pathWidth / 2, y: pathWidth / 2)
        let cPath = UIBezierPath(arcCenter: center, radius: 4, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        cicleLayer.fillColor = state == .normal ? UIColor.white.cgColor : selectColor
        cicleLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : selectColor
        cicleLayer.path = cPath.cgPath
        cicleLayer.frame = imageLayer.bounds
        //
        let dBegin = CGPoint(x: uBegin.x + 2, y: uBegin.y + 6)
        let dMid1 = CGPoint(x: dBegin.x + 5, y: dBegin.y + 5)
        let dControl = CGPoint(x: dMid1.x + 5, y: pathWidth + 1)
        let dMid2 = CGPoint(x: dMid1.x + 12, y: dMid1.y)
        let dEnd = CGPoint(x: dBegin.x + pathWidth, y: dBegin.y - 2)
        //
        let dPath = UIBezierPath()
        dPath.move(to: dBegin)
        dPath.addLine(to: dMid1)
        dPath.addQuadCurve(to: dMid2, controlPoint: dControl)
        dPath.addLine(to: dEnd)
        if state == .selected {
            let dInControl1 = CGPoint(x: dControl.x, y: dControl.y - 1)
            let dInControl2 = CGPoint(x: dBegin.x + 4, y: dBegin.y)
            let dInEnd = CGPoint(x: dMid2.x, y: dMid2.y - 2)
            dPath.addQuadCurve(to: dInEnd, controlPoint: CGPoint(x: dEnd.x, y: dEnd.y - 1))
            dPath.addCurve(to: dBegin, controlPoint1: dInControl1, controlPoint2: dInControl2)
        }
        
        downLayer.path = dPath.cgPath
        downLayer.strokeColor = state == .normal ? UIColor.gray.cgColor : selectColor
        //downLayer.fillColor = state == .normal ? UIColor.white.cgColor : selectColor
        downLayer.lineWidth = state == .normal ? 1.5 : 3.0
        downLayer.frame = imageLayer.bounds
    }
}
