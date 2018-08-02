//
//  LXTabBar.swift
//  LXTabBarCode
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

@objc protocol LXTabBarDelegate: NSObjectProtocol {
    func tabBar(_ bar: LXTabBar, didSelect index: Int)
    @objc optional func tabBar(_ bar: LXTabBar, willSelect index: Int)
    @objc optional func tabBar(_ bar: LXTabBar, shouldSelect index: Int) -> Bool
}

class LXTabBar: UIView {
    
    var items: [LXTabItem] = [LXTabItem]()
    weak var delegate: LXTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func addItem(_ item: LXTabItem) {
        item.tag = items.count
        items.append(item)
        addSubview(item)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard items.count > 0 else { return }
        let itemWidth = bounds.width / CGFloat(items.count)
        for (index, temp) in items.enumerated() {
            temp.frame = CGRect(x: CGFloat(index) * itemWidth, y: 0, width: itemWidth, height: bounds.height)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        // 查找点击的item
        var selectIndex: Int = 0
        for (index, temp) in items.enumerated() {
            if !temp.frame.contains(point) {
                continue
            }
            if temp.state == .selected {
                return
            }
            selectIndex = index
            break
        }
        if let select = delegate?.tabBar?(self, shouldSelect: selectIndex), !select {
            return
        }
        // 判断方向
        for (index, temp) in items.enumerated() {
            if index < selectIndex {
                temp.lookDirection = .right
                temp.state = .normal
            } else if index > selectIndex {
                temp.lookDirection = .left
                temp.state = .normal
            } else {
                temp.lookDirection = .center
                temp.state = .selected
            }
        }
        delegate?.tabBar?(self, willSelect: selectIndex)
        items[selectIndex].state = .selected
        delegate?.tabBar(self, didSelect: selectIndex)
    }
}
