//
//  MainViewController.swift
//  DYZB
//
//  Created by kk on 2017/10/11.
//  Copyright © 2017年 kk. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildVc(name: "Home")
        self.addChildVc(name: "Live")
        self.addChildVc(name: "Focous")
        self.addChildVc(name: "Profile")
        
    }
    //- 添加子控制器
    private func addChildVc(name: String){
        //1.通过storyboard获取控制器
        if let childVc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController(){
            //2.将childVc作为子控制器
            self.addChildViewController(childVc)
        }
    }

}
