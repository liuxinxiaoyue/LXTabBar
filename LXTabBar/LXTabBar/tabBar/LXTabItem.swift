//
//  LXTabItem.swift
//  LXTabBarCode
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

enum LXTabItemState {
    case normal
    case selected
}

enum LXTabItemLookDirection {
    case left
    case right
    case center
}

class LXTabItem: UIView {

    var state: LXTabItemState = .normal {
        didSet {
            generatePath()
            drawLabel()
        }
    }
    var lookDirection: LXTabItemLookDirection = .center
    var imageLayer: CALayer = {
        let layer = CALayer()
        return layer
    }()
    var imageContainerView: UIView = {
        let view = UIView()
        return view
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        var font = UIFont.systemFont(ofSize: 10)
        if #available(iOS 8.2, *) {
            font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(rawValue: 2))
        }
        label.font = font
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    var title: String? {
        didSet {
            drawLabel()
        }
    }
    var imageInset: UIEdgeInsets = UIEdgeInsets(top: 7, left: 0, bottom: 3, right: 0)
    var titleInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    private var titleHeight: CGFloat = 12.0
    private var titleAttributesForState: [LXTabItemState: [NSAttributedStringKey: Any]] = [LXTabItemState: [NSAttributedStringKey: Any]]()
    var imageRect: CGRect {
        get {
            let imgRect = CGRect(x: 0, y: imageInset.top, width: frame.width, height: frame.height - imageInset.top - imageInset.bottom - titleInset.top - titleInset.bottom - titleHeight)
            return imgRect
        }
    }
    var titleRect: CGRect {
        get {
            let textRect = CGRect(x: 0, y: imageRect.maxY + titleInset.top + imageInset.bottom, width: frame.width, height: titleHeight)
            return textRect
        }
    }
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            super.frame = newValue
            // 生成path
            generatePath()
        }
    }
    
    //MARK: - Init
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commInit()
    }
    
    private func commInit() {
        addSubview(imageContainerView)
        imageContainerView.layer.addSublayer(imageLayer)
        stepImageContent()
        addSubview(titleLabel)
    }
    
    //MARK: - 子类重写
    func stepImageContent() {
        
    }
    
    func generatePath() {
        if state == .selected {
            UIView.animateKeyframes(withDuration: 0.25, delay: 0.0, options: .calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.imageContainerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    self.imageContainerView.transform = CGAffineTransform.identity
                })
            }) { (finish) in
                
            }
        }
    }
    
    // 布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageContainerView.frame = imageRect
        imageLayer.frame = imageContainerView.bounds
        titleLabel.frame = titleRect
    }
    
    private func drawLabel() {
        var font = UIFont.systemFont(ofSize: 10)
        if #available(iOS 8.2, *) {
            font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(rawValue: 2))
        }
        let color = state == .normal ? UIColor.gray : UIColor(hexString: "43c1e2") ?? UIColor.blue
        let atts = titleAttributesForState[state] ?? [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color]
        if let str = title {
            titleLabel.attributedText = NSAttributedString(string: str, attributes: atts)
        }
    }
}
