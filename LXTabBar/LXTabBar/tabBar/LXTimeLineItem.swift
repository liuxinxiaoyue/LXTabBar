//
//  LXTimeLineItem.swift
//  LXTabBarCode
//
//  Created by admin on 2018/7/26.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class LXTimeLineItem: LXTabItem {

    private var bigStarLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.gray.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        layer.lineWidth = 1.5
        return layer
    }()

    private var smallStarLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.fillColor = UIColor.white.cgColor
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        layer.lineWidth = 1.0
        return layer
    }()
    
    //MARK: - 重写
    override func stepImageContent() {
        //
        imageLayer.addSublayer(bigStarLayer)
        //
        imageLayer.addSublayer(smallStarLayer)
    }
    
    override func generatePath() {
        super.generatePath()
        //
        let temp = imageRect
        let pathWidth: CGFloat = 25.0
        let pathRect = CGRect(x: (temp.width - pathWidth) / 2, y: temp.minY, width: pathWidth, height: pathWidth)
        //
        let bigPath = UIBezierPath()
        var a = CGPoint.zero, b = CGPoint.zero, c = CGPoint.zero, d = CGPoint.zero, e = CGPoint.zero
        var ab = CGPoint.zero, bc = CGPoint.zero, cd = CGPoint.zero, de = CGPoint.zero, ae = CGPoint.zero
        if state == .normal {
            let angle = Double.pi / 3
            let length: CGFloat = 10
            let sValue = length * CGFloat(sin(angle))
            let cValue = length * CGFloat(cos(angle))
            
            a = CGPoint(x: pathRect.minX + pathWidth / 2, y: 0)
            ab = CGPoint(x: a.x - cValue - 1, y: a.y + sValue)
            b = CGPoint(x: ab.x - length + 2, y: ab.y + 2)
            bc = CGPoint(x: b.x + sValue - 3, y: b.y + cValue + 1)
            c = CGPoint(x: bc.x - cValue + 5, y: bc.y + sValue)
            cd = CGPoint(x: c.x + sValue - 2, y: c.y - cValue + 1)
            d = CGPoint(x: cd.x + sValue + 1, y: c.y)
            de = CGPoint(x: d.x - 2, y: bc.y)
            ae = CGPoint(x: a.x + cValue - 1, y: sValue)
            e = CGPoint(x: ae.x + cValue + 3, y: b.y)
            
            bigStarLayer.fillColor = UIColor.white.cgColor
            bigStarLayer.strokeColor = UIColor.gray.cgColor
        } else if state == .selected {
            let angle = Double.pi / 3
            let length: CGFloat = 10
            let sValue = length * CGFloat(sin(angle))
            let cValue = length * CGFloat(cos(angle))
            
            a = CGPoint(x: pathRect.minX + pathWidth / 2, y: 0)
            ab = CGPoint(x: a.x - cValue, y: a.y + sValue)
            b = CGPoint(x: ab.x - length + 2, y: ab.y + 2)
            bc = CGPoint(x: b.x + sValue - 3, y: b.y + cValue + 1)
            c = CGPoint(x: bc.x - cValue + 5, y: bc.y + sValue)
            cd = CGPoint(x: c.x + sValue - 2, y: c.y - cValue + 1)
            d = CGPoint(x: cd.x + sValue + 1, y: c.y)
            de = CGPoint(x: d.x - 2, y: bc.y)
            ae = CGPoint(x: a.x + cValue - 1, y: sValue)
            e = CGPoint(x: ae.x + cValue + 3, y: b.y)
            
            let selectColor = UIColor(hexString: "48bcf5").cgColor
            bigStarLayer.fillColor = selectColor
            bigStarLayer.strokeColor = selectColor
        }
        bigPath.move(to: a)
        bigPath.addLine(to: ab)
        bigPath.addLine(to: b)
        bigPath.addLine(to: bc)
        bigPath.addLine(to: c)
        bigPath.addLine(to: cd)
        bigPath.addLine(to: d)
        bigPath.addLine(to: de)
        bigPath.addLine(to: e)
        bigPath.addLine(to: ae)
        bigPath.addLine(to: a)
        bigStarLayer.path = bigPath.cgPath
        bigStarLayer.frame = imageLayer.bounds
        
        //
        let angle = Double.pi / 3
        let length: CGFloat = 3
        let sValue = length * CGFloat(sin(angle))
        let cValue = length * CGFloat(cos(angle))
        
        a = CGPoint(x: 5, y: 0)
        ab = CGPoint(x: a.x - cValue, y: a.y + sValue)
        b = CGPoint(x: ab.x - sValue + 0.5, y: ab.y)
        bc = CGPoint(x: b.x + sValue - 1, y: b.y + cValue + 1)
        c = CGPoint(x: bc.x - cValue + 1, y: bc.y + sValue - 1)
        cd = CGPoint(x: c.x + sValue - 0.2, y: c.y - cValue + 0.5)
        d = CGPoint(x: cd.x + sValue, y: c.y)
        de = CGPoint(x: d.x - 0.7, y: bc.y)
        ae = CGPoint(x: a.x + cValue, y: sValue)
        e = CGPoint(x: ae.x + cValue + 0.5, y: b.y)
        
        let smallPath = UIBezierPath()
        smallPath.move(to: a)
        smallPath.addLine(to: ab)
        smallPath.addLine(to: b)
        smallPath.addLine(to: bc)
        smallPath.addLine(to: c)
        smallPath.addLine(to: cd)
        smallPath.addLine(to: d)
        smallPath.addLine(to: de)
        smallPath.addLine(to: e)
        smallPath.addLine(to: ae)
        smallPath.addLine(to: a)
        smallStarLayer.frame = CGRect(x: pathRect.minX + pathWidth - 8, y: 0, width: 10, height: 10)
        smallStarLayer.path = smallPath.cgPath
        if state == .selected {
            let selectColor = UIColor(hexString: "48bcf5").cgColor
            smallStarLayer.fillColor = selectColor
            smallStarLayer.strokeColor = selectColor
        } else {
            smallStarLayer.fillColor = UIColor.white.cgColor
            smallStarLayer.strokeColor = nil
        }
    }
}
