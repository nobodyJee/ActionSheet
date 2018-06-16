//
//  JWCActionSheetStyleList.swift
//  JWCActionSheet
//
//  Created by JiWuChao on 2018/6/16.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

protocol JWCStyleListDelegate:class {
    
    func styleList(list:JWCActionSheetStyleList, didSelectedIndex:Int, selectedTitle:String)
    
}

class JWCActionSheetStyleList: UIView {

    var styles:[String] = ["样式0","样式1","样式2","样式3","样式4","样式5"]
    
    weak var delegate:JWCStyleListDelegate?
    
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: UIScreen.main.bounds, style: .grouped)
//            table.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCells")
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = UIColor.white
        table.rowHeight = 40
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
}


extension JWCActionSheetStyleList:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCells")

        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "UITableViewCells")
        }
       
        
        if indexPath.row < styles.count {
            cell?.textLabel?.text = styles[indexPath.row]
            
            switch indexPath.row {
            case 0:
                cell?.detailTextLabel?.text = "使用快捷函数创建默认样式"
                break
            case 1:
                cell?.detailTextLabel?.text = "设置不同的字体和字体颜色"
                break

            case 2:
                cell?.detailTextLabel?.text = "设置不同的背景颜色"
                break

            case 3:
                cell?.detailTextLabel?.text = "添加头视图1"
                break

            case 4:
                cell?.detailTextLabel?.text = "添加头视图2"
                break
            case 5:
                cell?.detailTextLabel?.text = "列表样式"
                break
            default: break
            }
            
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        delegate?.styleList(list: self, didSelectedIndex: indexPath.row, selectedTitle: cell?.textLabel?.text ?? "出错了")
    }
    
    
    
}
