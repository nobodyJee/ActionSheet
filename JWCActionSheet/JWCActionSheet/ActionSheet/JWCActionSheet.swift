//
//  JWCActionSheet.swift
//  JWCActionSheet
//
//  Created by JiWuChao on 2018/6/16.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit


// MARK: -  JWCActionSheet 主类
class JWCActionSheet: JWCBaseContainer {
    
    typealias ResultCallback = (_ index: Int , _ title: String?) -> Void
    
    fileprivate var resultCallback : ResultCallback?
    
    fileprivate var items:[JWCActionSheetItem] = [JWCActionSheetItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate var headView:UIView?
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView.init(frame: UIScreen.main.bounds, style: UITableViewStyle.plain)
        table.register(JWCActionSheetCell.self, forCellReuseIdentifier: "JWCActionSheetCell")
        table.delegate = self
        table.dataSource = self
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = UIColor.white
        table.tableHeaderView = headView
        table.bounces = false
        table.separatorStyle = .none
        return table
    }()
    
   fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    /// 初始化方法 1
    ///
    /// - Parameters:
    ///   - items: <#items description#>
    ///   - headView: <#headView description#>
   fileprivate convenience init(items:[JWCActionSheetItem],headView:UIView? = nil) {
        
        self.init(frame: UIScreen.main.bounds)
        self.headView = headView
        self.items = items
        setupView()
    }
    
    
     /// 初始化方法 2
     ///
     /// - Parameters:
     ///   - titles: <#titles description#>
     ///   - headView: <#headView description#>
    fileprivate convenience init(titles:[String],headView:UIView? = nil) {
        self.init(frame: UIScreen.main.bounds)
        self.headView = headView
        self.items = createDefautItem(titles: titles)
        setupView()
    }
    
     /// 类方法1
     ///
     /// - Parameters:
     ///   - titles: 数据源 String 类型
     ///   - headView: <#headView description#>
     /// - Returns: <#return value description#>
     class func actionSheet(titles:[String],headView:UIView?) -> JWCActionSheet {
        let action = JWCActionSheet.init(titles: titles, headView: headView)
        return action
    }
    
     /// 类方法2
     ///
     /// - Parameters:
     ///   - items: 数据源 JWCActionSheetItem 类型的数组
     ///   - headView: headerView 如果没有则传 nil
     /// - Returns: <#return value description#>
     class func actionSheet(items:[JWCActionSheetItem],headView:UIView?) -> JWCActionSheet {
        let action = JWCActionSheet.init(items: items, headView: headView)
        return action
    }
    
    fileprivate func setupView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.bottom.trailing.leading.equalTo(self)
            make.height.equalTo(getTableViewHeight())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /// 弹出
    ///
    /// - Parameter callback: <#callback description#>
    func show(callback:(ResultCallback?)) {
        resultCallback = callback
        
        var window: UIWindow! = UIApplication.shared.delegate?.window as? UIWindow
        if window == nil {
            window = UIApplication.shared.keyWindow
        }
        
        if window.isKind(of: UIWindow.self) {
            window.addSubview(self)
            self.snp.makeConstraints { (make) in
                make.edges.equalTo(window)
            }
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        if tableView.isHidden {
            tableView.isHidden = false
        }
        let trans = transAni(type: kCATransitionMoveIn, subType: kCATransitionFromTop, function: kCAMediaTimingFunctionEaseOut)
        tableView.layer.add(trans, forKey: nil)
    }
    
    
    
    @objc func dissmiss(animation:Bool) {
        if animation {
            let trans = transAni(type: kCATransitionPush, subType: kCATransitionFromBottom, function: kCAMediaTimingFunctionLinear)
            trans.delegate = self
            tableView.layer.add(trans, forKey: nil)
            
            let ani = opacityReduce_Animation(time:0.4)
            self.layer.add(ani, forKey: nil)
        } else {
            removeFromSuperview()
        }
        tableView.isHidden = true
    }
    
    override func clickBg() {
        super.clickBg()
        dissmiss(animation: true)
        resultCallback?(-1, "什么都没选择,点击了空白处")
    }

     

}


extension JWCActionSheet:CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            removeFromSuperview()
        }
    }
}




extension JWCActionSheet {
    
    ///默认样式
    ///
    /// - Parameter titles: <#titles description#>
    /// - Returns: <#return value description#>
    fileprivate func createDefautItem(titles:[String]) -> [JWCActionSheetItem]{
        let itemTitles = titles
        var itemArr = [JWCActionSheetItem]()
        for (index,title) in itemTitles.enumerated() {
            var lineHeight:Float = 1.0
            if index == itemTitles.count - 2 {
                lineHeight = 5.0
            } else {
                if index == itemTitles.count - 1 {
                    lineHeight = 0.0
                } else {
                    lineHeight = 1
                }
            }
            let actionItem = JWCActionSheetItem.init(title: title, titleFont: UIFont.init(name: "PingFangSC-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17), titleColor: UIColor.black, height: 55, bottomLineHeight: lineHeight)
            itemArr.append(actionItem)
            
        }
        
        return itemArr
    }
    
    
    func getTableViewHeight() -> Float {
        
        var height:Float = 0.0
        
        for item in self.items {
            height = height + item.height + item.bottomLineHeight
        }
        height += Float(headView?.frame.height ?? 0)
        
        return height
    }
    
    
}



// MARK: - UITableViewDelegate,UITableViewDataSource
extension JWCActionSheet : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cellIndex = tableView.dequeueReusableCell(withIdentifier: "JWCActionSheetCell", for: indexPath)
        if let cell = cellIndex as? JWCActionSheetCell {
            if indexPath.row >= 0 && indexPath.row < items.count {
                cell.cellInfo = items[indexPath.row]
                cell.selectionStyle = .none
                if indexPath.row == items.count - 1 {
                    cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
                } else {
                    cell.separatorInset = UIEdgeInsets.zero
                }
            }
            return cell
        }
        return cellIndex
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row < items.count && indexPath.row >= 0 {
            let item = items[indexPath.row]
            return CGFloat(item.height + item.bottomLineHeight)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let head = headView else { return 0.0 }
        return head.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if let cel = cell as? JWCActionSheetCell {
            resultCallback?(indexPath.row,cel.cellInfo.title)
        }
        
        dissmiss(animation: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        
    }
    
    
}


// MARK: - JWCActionSheetCell 展示每一个选项的 cell
class JWCActionSheetCell: UITableViewCell {
    
    var cellInfo:JWCActionSheetItem = JWCActionSheetItem() {
        didSet {
            updateCell()
        }
    }
    
    fileprivate lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
   fileprivate lazy var line: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.lightGray
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setLayout() {
        contentView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.trailing.leading.equalTo(self)
            make.height.equalTo(1)
        }
        contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.trailing.leading.top.equalTo(self)
            make.bottom.equalTo(line.snp.top)
        }
    }
    
   fileprivate func updateCell() {
        titleLbl.text = self.cellInfo.title
        titleLbl.font = cellInfo.titleFont
        titleLbl.textColor = cellInfo.titleColor
        self.backgroundColor = cellInfo.backgroundColor
        line.backgroundColor = cellInfo.bottomLineColor
        line.snp.updateConstraints { (make) in
            make.height.equalTo(cellInfo.bottomLineHeight)
        }
    }
    
    
}

// MARK: -  JWCActionSheetItem 配置每一个选项(cell)的  属性 字体 间距 背景颜色等
class JWCActionSheetItem: NSObject {
    //标题
     var title:String = ""
    //标题颜色: 默认为黑
     var titleColor:UIColor = UIColor.black
    // 标题的字体,默认为14
     var titleFont = UIFont.systemFont(ofSize: 14)
    // item 的高度 默认为30
     var height:Float = 30
    //两个 item 的之间的分割线颜色 默认为灰色
     var bottomLineColor:UIColor = UIColor.init(white: 0, alpha: 0.2)
    //两个 item 的之间的分割线高度 默认为1
     var bottomLineHeight:Float = 1.0
    // item 的背景颜色
     var backgroundColor:UIColor = UIColor.white
    
     convenience init(title:String,titleColor:UIColor,titleFont:UIFont,height:Float,bottomLineColor:UIColor,bottomLineHeight:Float,backgroundColor:UIColor) {
        self.init()
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.height = height
        self.bottomLineColor = bottomLineColor
        self.bottomLineHeight = bottomLineHeight
        self.backgroundColor = backgroundColor
    }
    
     convenience init(title:String,titleFont:UIFont,titleColor:UIColor,height:Float,bottomLineHeight:Float) {
        self.init()
        self.title = title
        self.titleColor = titleColor
        self.height = height
        self.titleFont = titleFont
        self.bottomLineHeight = bottomLineHeight
    }
    
    
}



// MARK: -  JWCBaseContainer 弹出/隐藏 动画
class JWCBaseContainer: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        
        addTarget(self, action: #selector(clickBg), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willChangeStatusBar(notifi:)), name: NSNotification.Name.UIApplicationWillChangeStatusBarOrientation, object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //显示/隐藏动画
    func transAni(type:String ,subType:String,function:String) -> CATransition {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: function)
        animation.duration = 0.3
        animation.type = type
        animation.subtype = subType
        return animation
    }
    // 透明度渐渐变淡动画
    func opacityReduce_Animation(time : TimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath:"opacity")
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = time
        animation.autoreverses = true
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        return animation
    }
    
    
    @objc func clickBg() {
        
    }
    
    @objc func willChangeStatusBar(notifi:Notification) {
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}





