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
    private lazy var pageTitleView: PageTitleView = {[weak self] in
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        // 1.确定内容的frame
        let contentY = kStatusBarH + kNavigationBarH + kTitleViewH
        let contentFrame = CGRect(x: 0, y: contentY, width: kScreenW, height: kScreenH - contentY)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
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
        
        // 3.添加contentView
        pageContentView.backgroundColor = UIColor.purple
        view.addSubview(pageContentView)
        
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

// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetInde: Int) {
        pageTitleView.setTitle(withProgress: progress, sourceIndex: sourceIndex, targetIndex: targetInde)
    }
}
