//
//  ViewController.swift
//  JWCActionSheet
//
//  Created by JiWuChao on 2018/6/16.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    lazy var styleList: JWCActionSheetStyleList = {
        let list = JWCActionSheetStyleList.init(frame: UIScreen.main.bounds)
            list.delegate = self
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(styleList)
        styleList.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.title = "JWCActionSheet样式 以及使用"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:JWCStyleListDelegate {
    func styleList(list: JWCActionSheetStyleList, didSelectedIndex: Int, selectedTitle: String) {
//        print("index:\(didSelectedIndex),title:\(selectedTitle)")
        showStyle(style: didSelectedIndex)
    }
}


extension ViewController {
    
    func showStyle(style:Int)  {
        switch style {
        case 0:
            style0()
            break
        case 1:
            style1()
            break
        case 2:
            style2()
            break
        case 3:
            style3()
            break
        case 4:
            style4()
            break
        case 5:
            style5()
            break
        default: break
            
        }
    }
    
    
    // MARK: 默认样式
    func style0() {
        JWCActionSheet.actionSheet(titles: ["拍照","相册选取","取消"],headView:nil).show { (index, title) in
            print("index:\(index),title:\(String(describing: title))")
        }
    }
    
    // MARK: 设置不同的字体和字体颜色
    func style1() {
        
        let item0 = JWCActionSheetItem.init(title: "一年级", titleFont: UIFont.systemFont(ofSize: 15), titleColor: UIColor.green, height: 40, bottomLineHeight: 1)
         let item1 = JWCActionSheetItem.init(title: "二年级", titleFont: UIFont.systemFont(ofSize: 20), titleColor: UIColor.brown, height: 40, bottomLineHeight: 1)
        
        let item2 = JWCActionSheetItem.init(title: "三年级", titleFont: UIFont.systemFont(ofSize: 23), titleColor: UIColor.purple, height: 40, bottomLineHeight: 10)
        
        let item3 = JWCActionSheetItem.init(title: "取消", titleFont: UIFont.boldSystemFont(ofSize: 25), titleColor: UIColor.red, height: 50, bottomLineHeight: 0)
        
        JWCActionSheet.actionSheet(items: [item0,item1,item2,item3],headView:nil).show { (index, title) in
            print("index:\(index),title:\(title ?? "没title 为空")")
        }
        
        
    }
    
    // MARK: 设置不同的背景颜色
    func style2() {

        let item0 = JWCActionSheetItem.init(title: "初中", titleColor: UIColor.black, titleFont: UIFont.systemFont(ofSize: 15), height: 45, bottomLineColor: UIColor.init(white: 0, alpha: 0.2), bottomLineHeight: 1, backgroundColor: UIColor.yellow)
        
        
        let item1 = JWCActionSheetItem.init(title: "高中", titleColor: UIColor.brown, titleFont: UIFont.systemFont(ofSize: 20), height: 45, bottomLineColor: UIColor.init(white: 0, alpha: 0.2), bottomLineHeight: 1, backgroundColor: UIColor.green)
 
        let item2 = JWCActionSheetItem.init(title: "大学", titleColor: UIColor.green, titleFont: UIFont.systemFont(ofSize: 20), height: 45, bottomLineColor: UIColor.init(white: 0, alpha: 0.2), bottomLineHeight: 1, backgroundColor: UIColor.lightGray)
        
        
        let item3 = JWCActionSheetItem.init(title: "取消", titleFont: UIFont.boldSystemFont(ofSize: 25), titleColor: UIColor.red, height: 50, bottomLineHeight: 0)
        
        JWCActionSheet.actionSheet(items: [item0,item1,item2,item3],headView:nil).show { (index, title) in
            print("index:\(index),title:\(title ?? "没title 为空")")
        }
        
        
    }
    
    // MARK: 添加头视图1
    func style3() {
        
        let headerView = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
            headerView.text = "请选择获取照片的方式"
            headerView.textAlignment = .center
            headerView.font = UIFont.systemFont(ofSize: 15)
            headerView.textColor = UIColor.red
            headerView.backgroundColor = UIColor.blue
        JWCActionSheet.actionSheet(titles: ["拍照","相册选取","取消"], headView: headerView).show { (index, title) in
            print("index:\(index),title:\(String(describing: title))")
        }
        
    }
     // MARK: 添加头视图2
    func style4() {
        
        let headerView = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        headerView.text = "请选择获您的学历"
        headerView.textAlignment = .center
        headerView.font = UIFont.systemFont(ofSize: 15)
        headerView.textColor = UIColor.red
        headerView.backgroundColor = UIColor.blue
        
        let item0 = JWCActionSheetItem.init(title: "初中", titleColor: UIColor.black, titleFont: UIFont.systemFont(ofSize: 15), height: 45, bottomLineColor: UIColor.init(white: 0, alpha: 0.2), bottomLineHeight: 1, backgroundColor: UIColor.yellow)
        
        
        let item1 = JWCActionSheetItem.init(title: "高中", titleColor: UIColor.brown, titleFont: UIFont.systemFont(ofSize: 20), height: 45, bottomLineColor: UIColor.init(white: 0, alpha: 0.2), bottomLineHeight: 1, backgroundColor: UIColor.green)
        
        let item2 = JWCActionSheetItem.init(title: "大学", titleColor: UIColor.green, titleFont: UIFont.systemFont(ofSize: 20), height: 45, bottomLineColor: UIColor.init(white: 0, alpha: 0.2), bottomLineHeight: 1, backgroundColor: UIColor.lightGray)
        
        
        let item3 = JWCActionSheetItem.init(title: "取消", titleFont: UIFont.boldSystemFont(ofSize: 25), titleColor: UIColor.red, height: 50, bottomLineHeight: 0)
        
        JWCActionSheet.actionSheet(items: [item0,item1,item2,item3],headView:headerView).show { (index, title) in
            print("index:\(index),title:\(title ?? "没title 为空")")
        }
        
    }
    
    func style5() {
        
        let item0 = JWCActionSheetItem.init(title: "一年级", titleFont: UIFont.systemFont(ofSize: 20), titleColor: UIColor.green, height: 40, bottomLineHeight: 1)
        let item1 = JWCActionSheetItem.init(title: "二年级", titleFont: UIFont.systemFont(ofSize: 20), titleColor: UIColor.brown, height: 40, bottomLineHeight: 1)
        
        let item2 = JWCActionSheetItem.init(title: "三年级", titleFont: UIFont.systemFont(ofSize: 20), titleColor: UIColor.purple, height: 40, bottomLineHeight: 1)
        
        let item3 = JWCActionSheetItem.init(title: "四年级", titleFont: UIFont.boldSystemFont(ofSize: 20), titleColor: UIColor.red, height: 40, bottomLineHeight: 1)
        
        JWCActionSheet.actionSheet(items: [item0,item1,item2,item3],headView:nil).show { (index, title) in
            print("index:\(index),title:\(title ?? "没title 为空")")
        }
        
        
    }

}


