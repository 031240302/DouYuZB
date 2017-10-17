//
//  PageTitleView.swift
//  DYZB
//
//  Created by kk on 2017/10/11.
//  Copyright © 2017年 kk. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}


// MARK:- 定义常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK:- 定义类
class PageTitleView: UIView {
    // MARK:- 定义属性
    private var titles: [String]
    private var currentIndex: Int = 0
    weak var delegate: PageTitleViewDelegate?
    // MARK:- 懒加载属性
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    private lazy var titleLabels: [UILabel] = [UILabel]()
    
    // MARK:- 自定义构造函数
   init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}

// MARK:- 设置UI界面
extension PageTitleView {
    private func setupUI() {
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加title对应的Label
        setupTitleLabels()
        
        //3.设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setupTitleLabels() {
        
        //确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            label.tag = index
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)

            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes: )))
            label.addGestureRecognizer(tapGes)
        }
        
    }
    
    private func setupBottomMenuAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollLine
        // 2.1获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

// MARK:- 监听Label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer) {
        // 1.获取当前Label
        if let currentLabel = tapGes.view as? UILabel {
            // 2.获取之前的Label
            let preLabel = titleLabels[currentIndex]
            
            // 3.切换文字的颜色
            currentLabel.textColor = UIColor.orange
            preLabel.textColor = UIColor.darkGray
            
            // 4.保存最新Label的下标值
            currentIndex = currentLabel.tag
            // 5.滚动条位置发生改变
            let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
            UIView.animate(withDuration: 0.15, animations: {
                self.scrollLine.frame.origin.x = scrollLineX
            })
            // 6.通知代理
            delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        }
    }
}

// MARK:- 对外暴露的方法
extension PageTitleView  {
    func setTitle(withProgress: CGFloat, sourceIndex: Int, targetIndex: Int) {
            // 1.取出sourceLabel/targetLabel
            let sourceLabel = titleLabels[sourceIndex]
            let targetLabel = titleLabels[targetIndex]
        
            // 2. 处理滑块的逻辑
            let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            let movedX = moveTotalX * withProgress
            scrollLine.frame.origin.x = sourceLabel.frame.origin.x + movedX
            // 3. 处理颜色渐变
            // 3.1 取出变化的范围
            let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
            // 3.2变化sourceLabel
            sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * withProgress, g: kSelectedColor.1 - colorDelta.1 * withProgress, b: kSelectedColor.2 - colorDelta.2)
            // 3.3变化targetLabel
            targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * withProgress, g: kNormalColor.1 + colorDelta.1 * withProgress, b: kNormalColor.2 + colorDelta.2 * withProgress)
            // 4.记录最新的index
            currentIndex = targetIndex
    }
}
