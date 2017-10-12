//
//  HomeViewController.swift
//  DYZB
//
//  Created by kk on 2017/10/11.
//  Copyright © 2017年 kk. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK:- 懒加载属性
    private lazy var pageTitleView: PageTitleView = {
        let titles = ["推荐", "游戏", "娱乐", "趣玩", "颜值", "星秀"]
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
        
    }
}

//MARK:- 设置UI界面
extension HomeViewController{
    private func setupUI(){
        //1.设置导航栏
        setupNavigationBar()
        //2.添加TitleView
        view.addSubview(pageTitleView)
    }
    
    private func setupNavigationBar(){
        //1、设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", hightLightName: nil, size: nil)
        
        //2.设置右侧的item
        let size = CGSize(width: 30, height: 30)

        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightLightName:"Image_my_history_click", size: size)
      
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightLightName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightLightName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
    
}
