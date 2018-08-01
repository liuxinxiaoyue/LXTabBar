//
//  LXTabBarController.swift
//  LXTabBarCode
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class LXTabBarController: UITabBarController {

    var customeBar: LXTabBar = {
        let temp = LXTabBar()
        temp.backgroundColor = UIColor.white
        return temp
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        tabBar.backgroundColor = UIColor.white
        tabBar.backgroundImage = UIImage()
        
        customeBar.delegate = self
        tabBar.addSubview(customeBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        customeBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 49)
        tabBar.bringSubview(toFront: customeBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addController(_ controller: UIViewController, item: LXTabItem) {
        if viewControllers == nil || viewControllers?.count == 0 {
            item.state = .selected
        }
        customeBar.addItem(item)
        addChildViewController(controller)
    }
}

extension LXTabBarController: LXTabBarDelegate {
    
    func tabBar(_ bar: LXTabBar, didSelect index: Int) {
        selectedIndex = index
    }
}
