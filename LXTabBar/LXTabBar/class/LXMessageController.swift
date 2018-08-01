//
//  LXMessageController.swift
//  LXTabBarCode
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit

class LXMessageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        navigationItem.title = "消息"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "push", style: .plain, target: self, action: #selector(push))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc private func push() {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        navigationController?.xb_pushViewController(vc, animated: true)
    }
}
