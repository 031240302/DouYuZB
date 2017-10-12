//
//  UIBarButton-Extension.swift
//  DYZB
//
//  Created by kk on 2017/10/11.
//  Copyright © 2017年 kk. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    /*
    class func createItem(imageName: String, hightLightName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        btn.setImage(UIImage(named: hightLightName), for: UIControlState.highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
 */
    
    //便利构造函数: 1>convinece开头 2>在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName: String, hightLightName: String? , size: CGSize?) {
     //1.生成button
        let btn = UIButton()
        //2.设置图片
        btn.setImage(UIImage(named: imageName), for: UIControlState.normal)
        if let hightLightName = hightLightName {
            btn.setImage(UIImage(named: hightLightName), for: UIControlState.highlighted)
        }
        //3.设置尺寸
        if let size = size {
             btn.frame = CGRect(origin: CGPoint.zero, size: size)
        } else {
             btn.sizeToFit()
        }
        //4.生成item
        self.init(customView: btn)
    }
}
